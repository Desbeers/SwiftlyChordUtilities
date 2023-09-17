//
//  Tuning.swift
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
    /// Drop D tuning
    case guitarDropDTuning = "Drop D tuning"
    /// Open D tuning
    case guitarOpenDTuning = "Open D tuning"
}

public extension Tuning {
    /// The strings of the instrument
    var strings: [Int] {
        [0, 1, 2, 3, 4, 5]
    }
    /// The name of the strings
    var name: [Chord.Root] {
        switch self {
        case .guitarStandardETuning:
            [.e, .a, .d, .g, .b, .e]
            //["E", "A", "D", "G", "B", "e"]
        case .guitarOpenGTuning:
            [.d, .g, .d, .g, .b, .d]
            //["D", "G", "D", "G", "B", "d"]
        case .guitarDropDTuning:
            [.d, .a, .d, .g, .b, .e]
            //["D", "A", "D", "G", "B", "e"]
        case .guitarOpenDTuning:
            [.d, .a, .d, .fSharp, .a, .d]
            //["D", "A", "D", "F♯", "A", "d"]
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
        case .guitarDropDTuning:
            [-3, 4, 9, 14, 18, 23]
        case .guitarOpenDTuning:
            [-3, 4, 9, 13, 16, 21]
        }
    }
}
