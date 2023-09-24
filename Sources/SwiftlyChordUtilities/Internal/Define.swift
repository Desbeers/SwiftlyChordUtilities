//
//  Define.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// Create a `ChordDefinition` struct from a string which defines a Chord with a ChordPro *define* directive
///
///  For more information about the layout, have a look at https://www.chordpro.org/chordpro/directives-define/
///
/// - Parameter define: ChordPro string definition of the chord
/// - Returns: A  `ChordPostion` struct, if found, else `nil`
func define(from define: String, instrument: Instrument) -> ChordDefinition? {

    if let definition = define.firstMatch(of: defineRegex) {

        var frets: [Int] = []
        var fingers: [Int] = []

        let rootAndQuality = findRootAndQuality(chord: definition.1)
        guard
            let root = rootAndQuality.root,
            let quality = rootAndQuality.quality
        else {
            return nil
        }

        if let fretsDefinition = definition.3 {
            frets = fretsDefinition.components(separatedBy: .whitespacesAndNewlines).map { Int($0) ?? -1 }
        }
        while frets.count < instrument.strings.count { frets.append(0) }

        if let fingersDefinition = definition.4 {
            fingers = fingersDefinition.components(separatedBy: .whitespacesAndNewlines).map { Int($0) ?? 0 }
        }
        while fingers.count < instrument.strings.count { fingers.append(0) }

        let chordDefinition = ChordDefinition(
            id: UUID(),
            name: definition.1,
            frets: frets,
            fingers: fingers,
            baseFret: definition.2 ?? 1,
            root: root,
            quality: quality, 
            bass: rootAndQuality.bass,
            instrument: instrument
        )
        return chordDefinition
    }
    return nil
}
