//
//  Define.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen / Sascha Müller zum Hagen
//

import Foundation

/// Create a `ChordDefinition` struct from a string which defines a Chord with a ChordPro *define* directive
///
///  For more information about the layout, have a look at https://www.chordpro.org/chordpro/directives-define/
///
/// - Parameter define: ChordPro string definition of the chord
/// - Returns: A  `ChordPostion` struct, if found, else `nil`
func define(from define: String, tuning: Tuning) -> ChordDefinition? {

    if let match = define.wholeMatch(of: defineRegex) {
        let key = String(match.1)
        let define = match.2
        /// The SwiftyChords.ChordPostion does not allow to use any custom chords, because the key, and suffix are enum types
        /// Use a 'C major' as base to define th e new chord from
        
        let rootAndQuality = findRootAndQuality(chord: key)
        guard
            let root = rootAndQuality.root,
            let quality = rootAndQuality.quality
        else {
            return nil
        }
        var chord = ChordDefinition(
            id: UUID(),
            name: "",
            frets: [0, 0, 0, 0, 0, 0],
            fingers: [0, 0, 0, 0, 0, 0],
            baseFret: 1,
            root: root,
            quality: quality,
            tuning: tuning
        )
        /// try to get the chord out of the string without the finger position.
        let regexBase = #/base-fret(?<baseFret>[\s1-9]+)frets(?<frets>[\soOxXN0-9]+)(?<last>.*)/#
        if let resultBase = try? regexBase.wholeMatch(in: define) {

            

            if let conv = Int(String(resultBase.baseFret).trimmingCharacters(in: .whitespacesAndNewlines)) {
                chord.baseFret = conv
            }

            var fretsString = String(resultBase.frets).trimmingCharacters(in: .whitespacesAndNewlines)
            if !fretsString.isEmpty {
                fretsString = fretsString.replacingOccurrences(of: "[xX]", with: "-1", options: .regularExpression, range: nil)
                fretsString = fretsString.replacingOccurrences(of: "[oON]", with: "0", options: .regularExpression, range: nil)

                var fretsArr = fretsString.components(separatedBy: .whitespacesAndNewlines)
                fretsArr = fretsArr.filter { !$0.isEmpty }
                chord.frets = fretsArr.map { Int($0) ?? 0 }

                /// append elements to have at least 6. This is needed to prevent a system failure.
                while chord.frets.count < 6 { chord.frets.append(0) }
            }

            /// Now try to get the finger postions
            let regexFingers = #/fingers(?<fingers>[\s\-xXN0-9]+)(?<last>.*)/#
            if let resultFingers = try? regexFingers.wholeMatch(in: resultBase.last) {

                var fingersString = String(resultFingers.fingers).trimmingCharacters(in: .whitespacesAndNewlines)
                if !fingersString.isEmpty {
                    fingersString = fingersString.replacingOccurrences(of: "[xXN-]", with: "0", options: .regularExpression, range: nil)

                    var fingerArr = fingersString.components(separatedBy: .whitespacesAndNewlines)
                    fingerArr = fingerArr.filter { !$0.isEmpty }
                    chord.fingers = fingerArr.map { Int($0) ?? 0 }

                    /// append elements to have at least 6. This is needed to prevent a system failure
                    while chord.fingers.count < 6 { chord.fingers.append(0) }
                }
            }
        }
        /// Return the chord position
        return ChordDefinition(
            id: UUID(), 
            name: key,
            frets: chord.frets,
            fingers: chord.fingers,
            baseFret: chord.baseFret,
            root: chord.root,
            quality: chord.quality, 
            tuning: tuning
        )
    }
    return nil
}
