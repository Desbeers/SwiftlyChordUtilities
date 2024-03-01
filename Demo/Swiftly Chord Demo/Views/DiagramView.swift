//
//  DiagramView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DiagramView: View {
    /// The chord to show
    let chord: ChordDefinition
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    /// The current width of the diagram
    @AppStorage("Diagram Width") private var width: Double = 300
    /// The current appearance
    @AppStorage("Appearance") private var appearance: Appearance = .light
    /// The body of the `View`
    var body: some View {
        let color = appearance.colors
        ChordDefinitionView(chord: chord, width: width, options: chordDisplayOptions.displayOptions)
            .frame(height: width * 1.75)
            .foregroundStyle(color.primary, color.secondary)
            .background(appearance == .print ? Color.white : color.primary.opacity(0.2))
            .animation(.default, value: chordDisplayOptions.displayOptions)
    }
}
