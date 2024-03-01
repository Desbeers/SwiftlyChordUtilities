//
//  DatabaseView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DatabaseView: View {
    /// The chords in this `View`
    @State private var chords: [ChordDefinition] = []
    /// Chords model
    @Environment(ChordsModel.self) private var chordsModel
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    /// The body of the `View`
    var body: some View {
        VStack(spacing: 0) {
            chordDisplayOptions.rootPicker
                .pickerStyle(.segmented)
                .padding()
            GridView(chords: chords)
                .id(chordDisplayOptions.definition.root)
        }
        .task(id: chordDisplayOptions.definition.root) {
            filterChords()
        }
        .task(id: chordsModel.chords) {
            filterChords()
        }
    }
    /// Filter the chords by selected root
    private func filterChords() {
        chords = chordsModel.chords.matching(root: chordDisplayOptions.definition.root)
            .sorted(using: KeyPathComparator(\.quality))
    }
}
