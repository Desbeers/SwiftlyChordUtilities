//
//  DatabaseView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DatabaseView: View {
    @State private var chords: [ChordDefinition] = []

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
            chords = Chords.guitar.matching(root: options.definition.root)
        }
    }
}
