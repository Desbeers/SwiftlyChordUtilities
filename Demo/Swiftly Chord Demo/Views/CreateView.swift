//
//  CreateView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct CreateView: View {
    /// Chord Display Options
    @EnvironmentObject private var options: ChordDisplayOptions
    /// The body of the `View`
    var body: some View {
        ScrollView {
            CreateChordView()
                .padding()
        }
        .animation(.default, value: options.displayOptions)
        .task(id: options.instrument) {
            setDefinition()
        }
    }
    /// Set the definition
    private func setDefinition() {
        if let chord = ChordDefinition(name: "C", instrument: options.instrument) {
            options.definition = chord
        }
    }
}
