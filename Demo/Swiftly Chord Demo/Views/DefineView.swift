//
//  DefineView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DefineView: View {
    @State private var status: Status = .loading
    @State private var definition: String = "C base-fret 1 frets x 3 2 0 1 0 fingers 0 3 2 0 1 0"
    @State private var chord: ChordDefinition?
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
                    Text("let chord = ChordDefinition(definition: \"\(definition)\")")
                        .fontDesign(.monospaced)
                    DiagramView(chord: chord)
                    Label(
                        " A custom chord always has a * behind its name in the diagram",
                        systemImage: "info.circle.fill"
                    )
                    .font(.caption)
                }
            case .empty:
                Router.define.emptyMessage
            }
            Spacer()
        }
        .animation(.default, value: definition)
        .task(id: definition) {
            if definition.isEmpty {
                chord = nil
                status = .empty
            } else {
                chord = ChordDefinition(definition: definition, tuning: .guitarStandardETuning)
                status = chord == nil ? .empty : .ready
            }
        }
    }
}
