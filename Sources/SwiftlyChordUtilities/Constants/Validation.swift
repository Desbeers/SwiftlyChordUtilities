//
//  Validation.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI

public enum ChordValidation: String {
    case correct
    case wrongBassNote
    case wrongRootNote
    case wronggNotes

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
