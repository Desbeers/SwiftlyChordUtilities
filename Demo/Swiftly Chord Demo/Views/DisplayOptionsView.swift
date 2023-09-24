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
    @EnvironmentObject var options: ChordDisplayOptions
    var body: some View {
        Group {
            options.nameToggle
            HStack(spacing: 0) {
                Image(systemName: "textformat.size.larger")
                options.displayRootPicker
                Image(systemName: "textformat.size.smaller")
                options.displayQualityPicker
            }
            .padding(.leading)
            .labelsHidden()
            .disabled(!options.displayOptions.showName)
            options.fingersToggle
            options.notesToggle
            options.mirrorToggle
            options.playToggle
            HStack(spacing: 0) {
                Image(systemName: "guitars.fill")
                options.midiInstrumentPicker
            }
            .padding(.leading)
            .labelsHidden()
            .disabled(!options.displayOptions.showPlayButton)
        }
        .tint(.accentColor)
        .buttonStyle(.plain)
        .animation(.default, value: options.displayOptions)
    }
}
