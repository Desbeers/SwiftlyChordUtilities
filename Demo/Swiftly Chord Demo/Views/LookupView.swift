//
//  LookupView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct LookupView: View {
    @State private var name: String = "C"

    @State private var status: Status = .loading

    @State private var chords: [ChordDefinition] = []

    var body: some View {
        ScrollView {
            Text(Router.lookup.item.description)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.top)
            TextField("Name", text: $name, prompt: Text("Name of the chord chord"))
                .frame(maxWidth: 100)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            switch status {
            case .loading:
                ProgressView()
            case .ready:
                Text("let chord = ChordDefinition(name: \"\(name)\")")
                    .fontDesign(.monospaced)
                GridView(chords: chords)
            case .empty:
                Router.lookup.emptyMessage
            }

        }
        .animation(.default, value: status)
        .task(id: name) {
            if let chord = ChordDefinition(name: name, tuning: .guitarStandardETuning) {
                chords = Chords.guitar.matching(root: chord.root).matching(quality: chord.quality)
                status = .ready
            } else {
                chords = []
                status = .empty
            }
        }
    }
}
