//
//  DisplayOptionsView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DisplayOptionsView: View {
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    var body: some View {
        Group {
            chordDisplayOptions.nameToggle
            HStack(spacing: 0) {
                Image(systemName: "textformat.size.larger")
                chordDisplayOptions.displayRootPicker
                Image(systemName: "textformat.size.smaller")
                chordDisplayOptions.displayQualityPicker
            }
            .padding(.leading)
            .labelsHidden()
            .disabled(!chordDisplayOptions.displayOptions.showName)
            chordDisplayOptions.fingersToggle
            chordDisplayOptions.notesToggle
            chordDisplayOptions.mirrorToggle
            chordDisplayOptions.playToggle
            HStack(spacing: 0) {
                Image(systemName: "guitars.fill")
                chordDisplayOptions.midiInstrumentPicker
            }
            .padding(.leading)
            .labelsHidden()
            .disabled(!chordDisplayOptions.displayOptions.showPlayButton)
        }
        .lineLimit(nil)
        .tint(.accentColor)
        .buttonStyle(.plain)
        .animation(.default, value: chordDisplayOptions.displayOptions)
    }
}
