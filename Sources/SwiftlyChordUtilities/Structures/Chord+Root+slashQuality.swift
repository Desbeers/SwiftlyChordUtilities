//
//  Chord+Root+slashQuality.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension Chord.Root {

    /// Conver a `slash note` to a ``Chord/Quality`` value
    var slashQuality: Chord.Quality {
        switch self {
        case .c:
                .slashC
        case .cSharp:
                .slashCSharp
        case .dFlat:
                .minorSlashD
        case .d:
                .slashD
        case .dSharp:
                .slashDSharp
        case .eFlat:
                .minorSlashE
        case .e:
                .slashE
        case .f:
                .slashF
        case .fSharp:
                .slashCSharp
        case .gFlat:
                .minorSlashG
        case .g:
                .slashG
        case .gSharp:
                .slashGSharp
        case .aFlat:
                .minorSlashF
        case .a:
                .slashA
        case .aSharp:
                .slashA
        case .bFlat:
                .slashBFlat
        case .b:
                .slashB
        /// This should not happen
        case .none:
                .major
        }
    }
}
