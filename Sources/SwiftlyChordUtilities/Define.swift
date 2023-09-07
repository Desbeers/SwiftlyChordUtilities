//
//  Define.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen / Sascha Müller zum Hagen
//

import Foundation

/// Create a `ChordPosition` struct from a string which defines a Chord with a ChordPro *define* directive
///
///  For more information about the layout, have a look at https://www.chordpro.org/chordpro/directives-define/
///
/// - Parameter define: ChordPro string definition of the chord
/// - Returns: A  `ChordPostion` struct, if found, else `nil`
public func define(from define: String) -> ChordPosition? {

    if let match = define.wholeMatch(of: defineRegex) {
        let key = String(match.1)
        let define = match.2
        /// The SwiftyChords.ChordPostion does not allow to use any custom chords, because the key, and suffix are enum types
        /// Use a 'C major' as base to define th e new chord from
        let result = findRootAndQuality(chord: key)

        var chord = CustomChord(id: UUID(),
                                frets: [0, 0, 0, 0, 0, 0],
                                fingers: [0, 0, 0, 0, 0, 0],
                                baseFret: 1,
                                barres: [],
                                root: result.root ?? .c,
                                quality: result.quality ?? .major
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
                chord.frets = fretsArr.map { Int($0)! }

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
                    chord.fingers = fingerArr.map { Int($0)! }

                    /// append elements to have at least 6. This is needed to prevent a system failure
                    while chord.fingers.count < 6 { chord.fingers.append(0) }

                    /// set the barres but use not '0' as barres
                    let mappedItems = chord.fingers.map { ($0, 1) }
                    let counts = Dictionary(mappedItems, uniquingKeysWith: +)
                    for (key, value) in counts where value > 1 && key != 0 {
                        chord.barres.append(key)
                    }
                }
            }
        }
        /// Return the chord position
        return ChordPosition(frets: chord.frets,
                             fingers: chord.fingers,
                             baseFret: chord.baseFret,
                             barres: chord.barres,
                             midi: chord.midi.map({$0.note}),
                             key: chord.root,
                             suffix: chord.quality
        )
    }
    return nil
}
