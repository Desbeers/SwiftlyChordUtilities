//
//  ChordDisplayOptions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyStructCache

/**
 An `Observable` Class with SwiftUI elements

 This class contains Buttons and Pickers you can add to your application to change the appearance of the chord diagrams.

 To use these elements, this Class must be added to your application as an `EnvironmentObject`

 - Note: The ``ChordDefinition/DisplayOptions`` will be preserved on disk.
 */
public final class ChordDisplayOptions: ObservableObject {
    /// Init the Class with optional defaults
    public init(defaults: ChordDefinition.DisplayOptions? = nil) {
        do {
            displayOptions = try Cache.get(key: "DisplayOptions", as: ChordDefinition.DisplayOptions.self)
        } catch {
            displayOptions = defaults ?? .init()
        }
        self.definition = ChordDefinition(name: "C", tuning: .guitarStandardETuning)!
    }

    /// All the ``ChordDefinition/DisplayOptions``
    @Published public var displayOptions: ChordDefinition.DisplayOptions {
        didSet {
            try? Cache.set(key: "DisplayOptions", object: displayOptions)
        }
    }

    /// All the values of a ``ChordDefinition``
    @Published public var definition: ChordDefinition

    // MARK: Name Button

    /// SwiftUI `View` with a `Button` to show or hide the name of the chord
    public var nameButton: some View {
        Button(
            action: {
                self.displayOptions.showName.toggle()
            },
            label: {
                switch displayOptions.showName {
                case true:
                    Label("Show Name", systemImage: "a.square.fill")
                case false:
                    Label("No Name", systemImage: "a.square")
                }
            }
        )
    }

    // MARK: Notes Button

    /// SwiftUI `View` with a `Button` to show or hide the notes of the chord
    public var notesButton: some View {
        Button(
            action: {
                self.displayOptions.showNotes.toggle()
            },
            label: {
                switch displayOptions.showNotes {
                case true:
                    Label("Show Notes", systemImage: "music.note.list")
                case false:
                    Label("No Notes", systemImage: "music.note")
                }
            }
        )
    }

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

    // MARK: Fingers Button

    /// SwiftUI `View` with a `Button` to show or hide the fingers on the diagram
    public var fingersButton: some View {
        Button(
            action: {
                self.displayOptions.showFingers.toggle()
            },
            label: {
                switch displayOptions.showFingers {
                case true:
                    Label("Show Fingers", systemImage: "hand.raised.fingers.spread.fill")
                case false:
                    Label("No Fingers", systemImage: "hand.raised.fingers.spread")
                }
            }
        )
    }

    // MARK: Mirror Button

    /// SwiftUI `Button` to mirror the diagram
    public var mirrorButton: some View {
        Button(
            action: {
                self.displayOptions.mirrorDiagram.toggle()
            },
            label: {
                switch displayOptions.mirrorDiagram {
                case true:
                    Label("Left Handed", systemImage: "hand.point.left.fill")
                case false:
                    Label("Right Handed", systemImage: "hand.point.right.fill")
                }
            }
        )
    }

    // MARK: Play Button

    /// SwiftUI `Button` to show or hide the play button
    public var playButton: some View {
        Button(
            action: {
                self.displayOptions.showPlayButton.toggle()
            },
            label: {
                switch displayOptions.showPlayButton {
                case true:
                    Label("Show Play Button", systemImage: "play.fill")
                case false:
                    Label("No Play Butten", systemImage: "play")
                }
            }
        )
    }

    // MARK: Instrument Picker

    /// SwiftUI `Picker` to select a MIDI ``Midi/Instrument`` value
    public var instrumentPicker: some View {
        InstrumentPicker()
    }
    /// SwiftUI `Picker` to select a MIDI ``Midi/Instrument`` value
    struct InstrumentPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        public var body: some View {
            Picker("Instrument:", selection: $options.displayOptions.instrument) {
                ForEach(Midi.Instrument.allCases, id: \.rawValue) { value in
                    Text(value.label)
                        .tag(value)
                }
            }
        }
    }

    // MARK: Tuning Picker

    /// SwiftUI `Picker` to select a  ``Tuning`` value
    public var tuningPicker: some View {
        TuningPicker()
    }
    /// SwiftUI `Picker` to select a  ``Tuning`` value
    struct TuningPicker: View {
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        public var body: some View {
            Picker("Tuning:", selection: $options.displayOptions.tuning) {
                ForEach(Tuning.allCases, id: \.rawValue) { value in
                    Text(value.rawValue)
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
                ForEach(Chord.Root.allCases, id: \.rawValue) { value in
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

    // MARK: Frets Picker

    /// SwiftUI `View` with a `Picker` to select `fret` values
    public var fretsPicker: some View {
        FretsPicker(
            tuning: displayOptions.tuning,
            guitarTuningOrder: displayOptions.mirrorDiagram ? displayOptions.tuning.strings.reversed() :  displayOptions.tuning.strings
        )
    }

    /// SwiftUI `View` with a `Picker` to select `fret` values
    struct FretsPicker: View {
        /// The tuning
        let tuning: Tuning
        /// The order of the tuning
        let guitarTuningOrder: [Int]
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            HStack {
                ForEach(guitarTuningOrder, id: \.self) { fret in
#if !os(macOS)
                    Text("\(tuning.name[fret].display.symbol)")
                        .font(.title3)
#endif
                    Picker(
                        selection: $options.definition.frets[fret],
                        content: {
                            Text("⛌")
                                .tag(-1)
                                .foregroundColor(.red)
                            ForEach(0...5, id: \.self) { value in
                                Text("\(value)")
                                    .tag(value)
                            }
                        },
                        label: {
                            Text("\(tuning.name[fret].display.symbol)")
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
            tuning: displayOptions.tuning,
            guitarTuningOrder: displayOptions.mirrorDiagram ? displayOptions.tuning.strings.reversed() :  displayOptions.tuning.strings
        )
    }
    /// SwiftUI `View` with a `Picker` to select `finger` values
    struct FingersPicker: View {
        /// The tuning
        let tuning: Tuning
        /// The order of the tuning
        let guitarTuningOrder: [Int]
        /// Chord Display Options object
        @EnvironmentObject var options: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            HStack {
                ForEach(guitarTuningOrder, id: \.self) { finger in
#if !os(macOS)
                    Text("\(tuning.name[finger].display.symbol)")
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
                            Text("\(tuning.name[finger].display.symbol)")
                                .font(.title3)
                        }
                    )
                    //Divider()
                }
            }
        }
    }

    // MARK: Play Button

    /// SwiftUI `Button` to play the chord with MIDI
    public struct PlayButton: View {
        /// Public init
        public init(chord: ChordDefinition, instrument: Midi.Instrument) {
            self.chord = chord
            self.instrument = instrument
        }
        /// The chord to play
        let chord: ChordDefinition
        /// The instrument to use
        let instrument: Midi.Instrument
        /// The body of the `View`
        public var body: some View {
            Button(action: {
                chord.play(instrument: instrument)
            }, label: {
                Label("Play", systemImage: "play.fill")
            })
            .disabled(chord.frets.isEmpty)
        }
    }
}
