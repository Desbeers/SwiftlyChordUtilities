//
//  GuitarTuning.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

// MARK: Guitar Tuning

/// The tuning of the guitar
public enum GuitarTuning: Int, CaseIterable {
    // swiftlint:disable identifier_name
    case E
    case A
    case D
    case G
    case B
    case e
    // swiftlint:enable identifier_name

    /// The offset for each string from the base 'E'
    ///  - Note: Start with -1, because of the BaseFret value in `ChordDefinition`
    var offset: Int {
        switch self {
        case .E: -1
        case .A: 4
        case .D: 9
        case .G: 14
        case .B: 18
        case .e: 23
        }
    }
}
