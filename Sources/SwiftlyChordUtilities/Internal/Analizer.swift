//
//  Analizer.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// Find the root, quality and optional bass of a named chord
/// - Parameter chord: The name of the chord
/// - Returns: The root and quality
func findChordElements(chord: String) -> (root: Chord.Root?, quality: Chord.Quality?, bass: Chord.Root?) {
    var root: Chord.Root?
    var quality: Chord.Quality?
    var bass: Chord.Root?
    if let match = chord.firstMatch(of: chordRegex) {
        root = match.1
        if let qualityMatch = match.2 {
            quality = qualityMatch
        } else {
            quality = Chord.Quality.major
        }
        bass = match.3
    }
    return (root, quality, bass)
}

/// Try to validate a ``ChordDefinition``
/// - Parameter chord: The ``ChordDefinition``
/// - Returns: The ``ChordValidation``
func validateChord(chord: ChordDefinition) -> ChordValidation {
    if chord.quality == .unknown {
        return .wronggNotes
    }
    var validation: ChordValidation = .correct
    var notes = chord.components.filter { $0.note != .none} .uniqued(by: \.note).map(\.note)
    let components = getChordComponents(chord: chord, addBase: false)
    for component in components {
        if let bass = chord.bass {
            if notes.first != bass {
                return .wrongBassNote
            } else if !component.contains(bass) {
                notes.removeAll(where: { $0 == bass })
            }
        } else if notes.first != chord.root {
            validation = .wrongRootNote
        }
        if component.sorted() == notes.sorted() {
            return validation
        }
    }
    return .wronggNotes
}