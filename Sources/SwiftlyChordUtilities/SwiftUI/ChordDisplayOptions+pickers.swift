//
//  ChordDisplayOptions+pickers.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//


import SwiftUI

extension ChordDisplayOptions {

    // MARK: Display Root Picker

    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root/display`` value
    public var displayRootPicker: some View {
        DisplayRootPicker()
    }
    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root/display`` value
    struct DisplayRootPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Picker("Root:", selection: $options.displayOptions.rootDisplay) {
                ForEach(ChordDefinition.DisplayOptions.Display.Root.allCases, id: \.rawValue) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Display Quality Picker

    /// SwiftUI `View` with a `Picker` to select a ``Chord/Quality/display`` value
    public var displayQualityPicker: some View {
        DisplayQualityPicker()
    }
    /// SwiftUI `View` with a `Picker` to select a ``Chord/Quality/display`` value
    struct DisplayQualityPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Picker("Quality:", selection: $options.displayOptions.qualityDisplay) {
                ForEach(ChordDefinition.DisplayOptions.Display.Quality.allCases, id: \.rawValue) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Midi Instrument Picker

    /// SwiftUI `Picker` to select a MIDI ``Midi/Instrument`` value
    public var midiInstrumentPicker: some View {
        MidiInstrumentPicker()
    }
    /// SwiftUI `Picker` to select a MIDI ``Midi/Instrument`` value
    struct MidiInstrumentPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        public var body: some View {
            Picker("MIDI Instrument:", selection: $options.displayOptions.midiInstrument) {
                ForEach(Midi.Instrument.allCases, id: \.rawValue) { value in
                    Text(value.label)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Instrument Picker

    /// SwiftUI `Picker` to select a  ``Instrument`` value
    public var instrumentPicker: some View {
        InstrumentPicker()
    }
    /// SwiftUI `Picker` to select a  ``Instrument`` value
    struct InstrumentPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        public var body: some View {
            Picker("Instrument:", selection: $options.instrument) {
                ForEach(Instrument.allCases, id: \.rawValue) { value in
                    Text(value.label)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Root Picker

    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root`` value
    public var rootPicker: some View {
        RootPicker()
    }
    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root`` value
    struct RootPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Picker("Root:", selection: $options.definition.root) {
                ForEach(Chord.Root.allCases.dropFirst(), id: \.rawValue) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Quality Picker

    /// SwiftUI `View` with a `Picker` to select a ``Chord/Quality`` value
    public var qualityPicker: some View {
        QualityPicker()
    }
    /// SwiftUI `View` with a `Picker` to select a ``Chord/Quality`` value
    struct QualityPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Picker("Quality:", selection: $options.definition.quality) {
                ForEach(Chord.Quality.allCases, id: \.rawValue) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Bass Picker

    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root`` value as bass note
    public var bassPicker: some View {
        BassPicker()
    }
    /// SwiftUI `View` with a `Picker` to select a ``Chord/Root`` value as bass note
    struct BassPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The selected bass note
        @State private var bass: Chord.Root = .none
        /// The body of the `View`
        var body: some View {
            Picker("Bass:", selection: $bass) {
                ForEach(Chord.Root.allCases, id: \.rawValue) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }
            .task(id: bass) {
                options.definition.bass = bass == .none ? nil : bass
            }
        }
    }

    // MARK: Frets Picker

    /// SwiftUI `View` with a `Picker` to select `fret` values
    public var fretsPicker: some View {
        FretsPicker(
            instrument: definition.instrument,
            guitarTuningOrder: displayOptions.mirrorDiagram ? definition.instrument.strings.reversed() :  definition.instrument.strings
        )
    }

    /// SwiftUI `View` with a `Picker` to select `fret` values
    struct FretsPicker: View {
        /// The instrument
        let instrument: Instrument
        /// The order of the tuning
        let guitarTuningOrder: [Int]
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            HStack {
                ForEach(guitarTuningOrder, id: \.self) { fret in
#if !os(macOS)
                    Text("\(instrument.stringName[fret].display.symbol)")
                        .font(.title3)
#endif
                    Picker(
                        selection: $options.definition.frets[fret],
                        content: {
                            Text("⛌")
                                .tag(-1)
                                .foregroundColor(.red)
                            ForEach(0...5, id: \.self) { value in
                                /// Calculate the fret note
                                /// - Note: Only add the basefret after the first row because the note can still be played open
                                let fret = options.definition.instrument.offset[fret] + (value == 0 ? 1 : options.definition.baseFret) + 40 + value
                                /// Convert the fret to a label
                                let label = valueToNote(value: fret, scale: options.definition.root)
                                Text(label.display.symbol)
                                    .tag(value)
                            }
                        },
                        label: {
                            Text("\(instrument.stringName[fret].display.symbol)")
                                .font(.title3)
                        }
                    )
                }
            }
        }
    }

    // MARK: Fingers Picker

    /// SwiftUI `View` with a `Picker` to select `finger` values
    public var fingersPicker: some View {
        FingersPicker(
            instrument: definition.instrument,
            guitarTuningOrder: displayOptions.mirrorDiagram ? definition.instrument.strings.reversed() :  definition.instrument.strings
        )
    }
    /// SwiftUI `View` with a `Picker` to select `finger` values
    struct FingersPicker: View {
        /// The instrument
        let instrument: Instrument
        /// The order of the tuning
        let guitarTuningOrder: [Int]
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            HStack {
                ForEach(guitarTuningOrder, id: \.self) { finger in
#if !os(macOS)
                    Text("\(instrument.stringName[finger].display.symbol)")
                        .font(.title3)
#endif
                    Picker(
                        selection: $options.definition.fingers[finger],
                        content: {
                            ForEach(0...4, id: \.self) { value in
                                Text("\(value)")
                                    .tag(value)
                            }
                        },
                        label: {
                            Text("\(instrument.stringName[finger].display.symbol)")
                                .font(.title3)
                        }
                    )
                    //Divider()
                }
            }
        }
    }
}
