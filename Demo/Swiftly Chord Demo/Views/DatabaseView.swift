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
    @EnvironmentObject private var model: ChordsModel
    /// Chord Display Options
    @EnvironmentObject private var options: ChordDisplayOptions
    /// The body of the `View`
    var body: some View {
        VStack(spacing: 0) {
            options.rootPicker
                .pickerStyle(.segmented)
                .padding()
            GridView(chords: chords)
                .id(options.definition.root)
        }
        .task(id: options.definition.root) {
            filterChords()
        }
        .task(id: model.chords) {
            filterChords()
        }
    }
    /// Filter the chords by selected root
    private func filterChords() {
        chords = model.chords.matching(root: options.definition.root)
    }
}
