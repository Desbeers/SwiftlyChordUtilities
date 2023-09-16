//
//  Chord+Root.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension Chord {

    public enum Root: String, CaseIterable, Codable, Comparable {
        // swiftlint:disable identifier_name
        case c = "C"
        case cSharp = "C#"
        case dFlat = "Db"
        case d = "D"
        case dSharp = "D#"
        case eFlat = "Eb"
        case e = "E"
        case f = "F"
        case fSharp = "F#"
        case gFlat = "Gb"
        case g = "G"
        case gSharp = "G#"
        case aFlat = "Ab"
        case a = "A"
        case aSharp = "A#"
        case bFlat = "Bb"
        case b = "B"
        // swiftlint:enable identifier_name
        case none

        /// Implement Comparable
        public static func < (lhs: Self, rhs: Self) -> Bool {
            allCases.firstIndex(of: lhs) ?? 0 < allCases.firstIndex(of: rhs) ?? 1
        }

        /// Contains text for accessibility text-to-speech and symbolized versions.
        public var display: (accessible: String, symbol: String) {
            switch self {
            case .c:
                ("C", "C")
            case .cSharp:
                ("C sharp", "C♯")
            case .dFlat:
                ("D flat", "D♭")
            case .d:
                ("D", "D")
            case .dSharp:
                ("D sharp", "D♯")
            case .eFlat:
                ("E flat", "E♭")
            case .e:
                ("E", "E")
            case .f:
                ("F", "F")
            case .fSharp:
                ("F sharp", "F♯")
            case .gFlat:
                ("G flat", "G♭")
            case .g:
                ("G", "G")
            case .gSharp:
                ("G sharp", "G♯")
            case .aFlat:
                ("A flat", "A♭")
            case .a:
                ("A", "A")
            case .aSharp:
                ("A sharp", "A♯")
            case .bFlat:
                ("B flat", "B♭")
            case .b:
                ("B", "B")
            case .none:
                ("X", "X")
            }
        }
    }
}

public extension Chord.Root {

    /// Transpose a note
    /// - Parameters:
    ///   - transpose: The transpose value
    ///   - scale: The scale of the note
    mutating func transpose(transpose: Int, scale: Chord.Root) {
        self = transposeNote(note: self, transpose: transpose, scale: scale)
    }
}

extension String {

    /// Convert a `Root` string to a `Root` enum
    var rootEnumValue: Chord.Root? {
        Chord.Root(rawValue: self)
    }
}
