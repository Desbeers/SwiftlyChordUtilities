//
//  Chord.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

/// Bits and pieces that makes a ``ChordDefinition``
public enum Chord {

    /// The grouping of chords
    public enum Group {
        /// Major chords
        case major
        /// Minor chords
        case minor
        /// Diminished chords
        case diminished
        /// Augmented chords
        case augmented
        /// Suspended chords
        case suspended
        /// All other chords
        case other
    }
}
