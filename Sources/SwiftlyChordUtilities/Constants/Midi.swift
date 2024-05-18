//
//  Midi.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

// MARK: Midi

/// Play ` ``ChordDefinition`` with MIDI
public enum Midi {
    /// Just a placeholder
}

public extension Midi {

    /// The available MIDI instruments
    enum Instrument: Int, CaseIterable, Codable, Sendable {
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
