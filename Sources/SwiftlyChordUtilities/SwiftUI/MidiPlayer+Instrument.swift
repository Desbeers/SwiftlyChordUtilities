//
//  File.swift
//  
//
//  Created by Nick Berendsen on 29/08/2023.
//

import SwiftUI

public extension MidiPlayer {

    /// The available MIDI instruments
    enum Instrument: Int, CaseIterable {
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

public extension MidiPlayer {

    /// SwiftUI Picker to select a MIDI instrument
    struct InstrumentPicker: View {
        /// Public init
        public init() {}
        /// The MIDI instrument
        @AppStorage("MIDI instrument") private var midiInstrument: MidiPlayer.Instrument = .acousticNylonGuitar
        /// The body of the View
        public var body: some View {
            Picker("Instrument:", selection: $midiInstrument) {
                ForEach(MidiPlayer.Instrument.allCases, id: \.rawValue) { value in
                    Text(value.label)
                        .tag(value)
                }
            }
        }
    }
}
