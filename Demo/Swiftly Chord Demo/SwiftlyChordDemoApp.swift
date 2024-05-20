//
//  SwiftlyChordDemoApp.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

@main struct SwiftlyChordDemoApp: App {
    /// Set the defaults for te diagram display
    static let defaults = ChordDefinition.DisplayOptions(
        showName: true,
        showNotes: true,
        showPlayButton: true,
        rootDisplay: .symbol,
        qualityDisplay: .symbolized,
        showFingers: true,
        mirrorDiagram: false
    )
    /// Chords model
    @State private var chordsModel = ChordsModel()
    /// Chord Display Options
    @State private var chordDisplayOptions = ChordDisplayOptions(defaults: defaults)
    /// The body of the `Scene`
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(chordsModel)
                .environment(chordDisplayOptions)
            /// Load the chords from the selected instrument
                .task(id: chordDisplayOptions.displayOptions.instrument) {
                    switch chordDisplayOptions.displayOptions.instrument {
                    case .guitarStandardETuning:
                        chordsModel.chords = Chords.guitar
                    case .guitaleleStandardATuning:
                        chordsModel.chords = Chords.guitalele
                    case .ukuleleStandardGTuning:
                        chordsModel.chords = Chords.ukulele
                    }
                }
        }
    }
}
