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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                options.fingersButton
                options.notesButton
                options.mirrorButton
            }
            Rectangle()
                .frame(width: 1, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                options.nameButton
                HStack {
                    Image(systemName: "textformat.size.larger")
                    options.displayRootPicker
                    Image(systemName: "textformat.size.smaller")
                    options.displayQualityPicker
                }
                .disabled(!options.displayOptions.showName)
            }
            Rectangle()
                .frame(width: 1, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                options.playButton
                HStack {
                    Image(systemName: "guitars.fill")
                    options.instrumentPicker
                }
                .disabled(!options.displayOptions.showPlayButton)
            }
        }
        .labelsHidden()
        .padding(.top)
        .buttonStyle(.plain)
        .animation(.default, value: options.displayOptions)
    }
}
