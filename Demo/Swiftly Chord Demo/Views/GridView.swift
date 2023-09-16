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
    @EnvironmentObject var options: ChordDisplayOptions

    @AppStorage("Diagram Width") private var width: Double = 300
    @AppStorage("Appearance") private var appearance: Appearance = .light

    let chords: [ChordDefinition]

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
        .animation(.default, value: options.displayOptions)
        .animation(.default, value: chords)
    }
}
