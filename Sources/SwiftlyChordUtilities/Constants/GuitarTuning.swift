//
//  GuitarTuning.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// The tuning of the instrument
public enum Tuning: String, CaseIterable, Codable {
    /// Standard E tuning
    case guitarStandardETuning = "Standard E tuning"
    /// Open G tuning
    case guitarOpenGTuning = "Open G tuning"
}

public extension Tuning {
    /// The strings of the instrument
    var strings: [Int] {
        [0, 1, 2, 3, 4, 5]
    }
    /// The name of the strings
    var name: [String] {
        switch self {
        case .guitarStandardETuning:
            ["E", "A", "D", "G", "B", "e"]
        case .guitarOpenGTuning:
            ["D", "G", "D", "G", "B", "d"]
        }
    }
    /// The offset for each string from the base 'E'
    ///  - Note: Start with -1, because of the BaseFret value in `ChordDefinition`
    var offset: [Int] {
        switch self {
        case .guitarStandardETuning:
            [-1, 4, 9, 14, 18, 23]
        case .guitarOpenGTuning:
            [-3, 2, 9, 14, 18, 21]
        }
    }
}


// MARK: Guitar Tuning

public extension Tuning {

    enum GuitarStandardETuning: Int, CaseIterable {
        // swiftlint:disable identifier_name
        case string1
        case string2
        case string3
        case string4
        case string5
        case string6
        // swiftlint:enable identifier_name

        var name: String {
            switch self {
            case .string1: "E"
            case .string2: "A"
            case .string3: "D"
            case .string4: "G"
            case .string5: "B"
            case .string6: "e"
            }
        }

        /// The offset for each string from the base 'E'
        ///  - Note: Start with -1, because of the BaseFret value in `ChordDefinition`
        var offset: Int {
            switch self {
            case .string1: -1
            case .string2: 4
            case .string3: 9
            case .string4: 14
            case .string5: 18
            case .string6: 23
            }
        }
    }

    enum GuitarOpenGTuning: Int, CaseIterable {
        // swiftlint:disable identifier_name
        case string1
        case string2
        case string3
        case string4
        case string5
        case string6
        // swiftlint:enable identifier_name

        var name: String {
            switch self {
            case .string1: "D"
            case .string2: "G"
            case .string3: "D"
            case .string4: "G"
            case .string5: "B"
            case .string6: "D"
            }
        }

        /// The offset for each string from the base 'E'
        ///  - Note: Start with -1, because of the BaseFret value in `ChordDefinition`
        var offset: Int {
            switch self {
            case .string1: -1
            case .string2: 4
            case .string3: 9
            case .string4: 14
            case .string5: 18
            case .string6: 23
            }
        }
    }
}
