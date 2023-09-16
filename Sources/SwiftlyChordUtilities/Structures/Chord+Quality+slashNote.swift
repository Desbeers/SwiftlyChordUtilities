//
//  Chord+Quality+slashNote.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension Chord.Quality {

    /// The bass note if it is not the root (slash chord)
    var slashNote: Chord.Root? {
        switch self {
        case .slashE:
                .e
        case .slashF:
                .f
        case .slashFSharp:
                .fSharp
        case .slashG:
                .g
        case .slashGSharp:
                .gSharp
        case .slashA:
                .a
        case .slashBFlat:
                .bFlat
        case .slashB:
                .b
        case .slashC:
                .c
        case .slashCSharp:
                .cSharp
        case .minorSlashB:
                .bFlat
        case .minorSlashC:
                .c
        case .minorSlashCSharp:
                .cSharp
        case .slashD:
                .d
        case .minorSlashD:
                .dFlat
        case .slashDSharp:
                .dSharp
        case .minorSlashDSharp:
                .dSharp
        case .minorSlashE:
                .e
        case .minorSlashF:
                .f
        case .minorSlashFSharp:
                .fSharp
        case .minorSlashG:
                .g
        case .minorSlashGSharp:
                .gSharp
        default:
            nil
        }
    }
}
