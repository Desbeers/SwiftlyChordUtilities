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
/// - Returns: A  `ChordPostion` struct, if found, else an Error
func define(from define: String, instrument: Instrument) throws -> ChordDefinition {

    if let definition = define.firstMatch(of: defineRegex) {

        let positions = instrument.strings.count

        var frets: [Int] = []
        var fingers: [Int] = []

        let elements = findChordElements(chord: definition.1)
        guard
            let root = elements.root,
            let quality = elements.quality
        else {
            throw ChordDefinitionError.noChord
        }

        if let fretsDefinition = definition.3 {
            frets = fretsDefinition.components(separatedBy: .whitespacesAndNewlines).map { Int($0) ?? -1 }
        }

        if let fingersDefinition = definition.4 {
            fingers = fingersDefinition.components(separatedBy: .whitespacesAndNewlines).map { Int($0) ?? 0 }
        }
        /// Fill the fingers if not set (complete)
        while fingers.count < instrument.strings.count { fingers.append(0) }
        /// Throw an error if the defined frets does not mach the instrument
        if frets.count < positions {
            throw ChordDefinitionError.notEnoughFrets
        }
        if frets.count > positions {
            throw ChordDefinitionError.toManyFrets
        }

        let chordDefinition = ChordDefinition(
            id: UUID(),
            name: definition.1,
            frets: frets,
            fingers: fingers,
            baseFret: definition.2 ?? 1,
            root: root,
            quality: quality, 
            bass: elements.bass,
            instrument: instrument
        )
        return chordDefinition
    }
    throw ChordDefinitionError.noChord
}
