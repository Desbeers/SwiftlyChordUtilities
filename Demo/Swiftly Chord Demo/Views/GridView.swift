//
//  GridView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct GridView: View {
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    /// The current width of the diagram
    @AppStorage("Diagram Width") private var width: Double = 300
    /// The current appearance
    @AppStorage("Appearance") private var appearance: Appearance = .light
    /// The chords to show
    let chords: [ChordDefinition]
    /// The body of the `View`
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: width))],
                alignment: .center,
                spacing: 4,
                pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                ForEach(chords) { chord in
                    DiagramView(chord: chord)
                }
            }
            .padding(.horizontal)
        }
        .animation(.default, value: chordDisplayOptions.displayOptions)
        .animation(.default, value: chords)
    }
}
