//
//  Validation.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI

/// The validation of a ``ChordDefinition``
public enum ChordValidation: String {
    /// The definition is correct
    case correct
    /// The definition has a wrong bass note
    case wrongBassNote
    /// The definition has a wrong root note
    case wrongRootNote
    /// The definition contains wrong notes
    case wronggNotes
    /// The color for a label
    public var color: Color {
        switch self {
        case .correct:
                .accentColor
        case .wrongBassNote:
                .red
        case .wrongRootNote:
                .purple
        case .wronggNotes:
                .red
        }
    }
    /// The label for the validations
    public var label: String {
        switch self {
        case .correct:
            "The chord seems correct"
        case .wrongBassNote:
            "The chord does not start with the bass note"
        case .wrongRootNote:
            "The chord does not start with the root note"
        case .wronggNotes:
            "The chord contains incorrect notes"
        }
    }
}
