//
//  DefineView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DefineView: View {
    /// The status of the `View`
    @State private var status: Status = .loading
    /// The chord definition
    @State private var definition: String = "C base-fret 1 frets x 3 2 0 1 0 fingers 0 3 2 0 1 0"
    /// The optional diagram
    @State private var chord: ChordDefinition?
    /// Chords model
    @Environment(ChordsModel.self) private var chordsModel
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    /// The body of the `View`
    var body: some View {
        ScrollView {
            Text("Define a chord in **ChordPro** format")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.top)
            // swiftlint:disable:next line_length
            Text("See the [ChordPro website](https://www.chordpro.org/chordpro/directives-define/) how to define a chord")
                .padding()
            TextField("Definition", text: $definition, prompt: Text("Define your chord"))
                .frame(maxWidth: 400)
                .textFieldStyle(.roundedBorder)
            Spacer()
            switch status {
            case .loading:
                ProgressView()
            case .ready:
                if let chord {
                    // swiftlint:disable:next line_length
                    Text("let chord = ChordDefinition(definition: \"\(definition)\", instrument: .\(chordDisplayOptions.displayOptions.instrument.rawValue))")
                        .fontDesign(.monospaced)
                        .padding()
                    DiagramView(chord: chord)
                }
            case .empty:
                Router.define.emptyMessage
            }
            Spacer()
        }
        .animation(.default, value: definition)
        .task(id: definition) {
            defineChord()
        }
        .task(id: chordsModel.chords) {
            defineChord()
        }
    }
    /// Define the chord
    private func defineChord() {
        if definition.isEmpty {
            chord = nil
            status = .empty
        } else {
            chord = try? ChordDefinition(
                definition: definition,
                instrument: chordDisplayOptions.displayOptions.instrument,
                status: .unknown
            )
            status = chord == nil ? .empty : .ready
        }
    }
}
