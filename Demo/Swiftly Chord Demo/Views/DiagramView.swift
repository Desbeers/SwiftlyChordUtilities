//
//  DiagramView.swift
//  Swiftly Chord Demo
//
//  Created by Nick Berendsen on 15/09/2023.
//

import SwiftUI
import SwiftlyChordUtilities

struct DiagramView: View {
    let chord: ChordDefinition

    /// Chord Display Options
    @EnvironmentObject private var options: ChordDisplayOptions

    @AppStorage("Diagram Width") private var width: Double = 300
    @AppStorage("Appearance") private var appearance: Appearance = .light

    var body: some View {
        let color = appearance.colors
        ChordDefinitionView(chord: chord, width: width, options: options.displayOptions)
            .frame(height: width * 1.6)
            .foregroundStyle(color.primary, color.secondary)
            .background(appearance == .print ? Color.white : color.primary.opacity(0.2))
            .animation(.default, value: options.displayOptions)
    }
}
