//
//  Midi.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

// MARK: Midi

/// Convert `fret` positions to MIDI notes
public enum Midi {
    /// Just a placeholder
}

extension Midi {

//    // MARK: Fret positions to notes and MIDI values
//
//    /// Calculate the MIDI values for a `ChordDefinition` struct
//    /// - Parameter values: The `ChordDefinition` midi values
//    /// - Returns: An array of `Int`'s
//    static func values(values: ChordDefinition) -> [Int] {
//        return fretsToComponents(frets: values.frets, baseFret: values.baseFret).compactMap(\.midi)
//    }

//    /// Calculate the chord components
//    static func calculateComponents(frets: [Int], baseFret: Int) -> [Chord.Component] {
//        var components: [Chord.Component] = []
//        if !frets.isEmpty {
//            for string in GuitarTuning.allCases {
//                var fret = frets[string.rawValue]
//                /// Don't bother with ignored frets
//                if fret == -1 {
//                    components.append(Chord.Component(note: .none, midi: nil))
//                } else {
//                    /// Add base fret if the fret is not 0 and the offset
//                    fret += string.offset + (fret == 0 ? 1 : baseFret) + 40
//                    let key = valueToNote(value: fret)
//                    components.append(Chord.Component(note: key, midi: fret))
//                }
//            }
//        }
//        return components
//    }
}

public extension Midi {

    /// The available MIDI instruments
    enum Instrument: Int, CaseIterable, Codable {
        case acousticNylonGuitar = 24
        case acousticSteelGuitar
        case electricJazzGuitar
        case electricCleanGuitar
        case electricMutedGuitar
        case overdrivenGuitar
        case distortionGuitar

        //// The label for the instrument
        public var label: String {
            switch self {
            case .acousticNylonGuitar:
                return "Acoustic Nylon Guitar"
            case .acousticSteelGuitar:
                return "Acoustic Steel Guitar"
            case .electricJazzGuitar:
                return "Electric Jazz Guitar"
            case .electricCleanGuitar:
                return "Electric Clean Guitar"
            case .electricMutedGuitar:
                return "Electric Muted Guitar"
            case .overdrivenGuitar:
                return "Overdriven Guitar"
            case .distortionGuitar:
                return "Distortion Guitar"
            }
        }
    }
}
