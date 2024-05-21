//
//  ChordDefinitionError.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

enum ChordDefinitionError: String, LocalizedError {
    case noChord
    case toManyFrets
    case notEnoughFrets

    // MARK: Protocol items

    /// The description of the status
    public var description: String {
        switch self {
        case .noChord:
            "Not a chord"
        case .toManyFrets:
            "To many frets"
        case .notEnoughFrets:
            "Not enough frets"
        }
    }
    /// The error description of the status
    public var errorDescription: String? {
        description
    }

    /// The recovery suggestion of the status
    var recoverySuggestion: String? {
        switch self {
        case .noChord:
            "this definition does not have a valid chord name"
        case .toManyFrets:
            "You can not edit this chord definition because it has to many frets defined for you current instrument."
        case .notEnoughFrets:
            "You can not edit this chord definition because it has not enough frets defined for you current instrument."
        }
    }
}
