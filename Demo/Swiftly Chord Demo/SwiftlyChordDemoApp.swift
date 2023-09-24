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
    @StateObject private var model = ChordsModel()
    /// Chord Display Options
    @StateObject private var options = ChordDisplayOptions(defaults: defaults)
    /// The body of the `Scene`
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(options)
            /// Load the chords from the selected instrument
                .task(id: options.instrument) {
                    switch options.instrument {
                    case .guitarStandardETuning:
                        model.chords = Chords.guitar
                    case .guitaleleStandardATuning:
                        model.chords = Chords.guitalele
                    case .ukuleleStandardGTuning:
                        model.chords = Chords.ukulele
                    }
                }
        }
    }
}
