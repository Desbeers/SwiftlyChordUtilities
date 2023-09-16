//
//  SwiftlyChordDemoApp.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

@main
struct SwiftlyChordDemoApp: App {
    static let defaults = ChordDefinition.DisplayOptions(
        showName: true,
        showNotes: true,
        showPlayButton: true,
        rootDisplay: .symbol,
        qualityDisplay: .symbolized,
        showFingers: true,
        mirrorDiagram: false
    )
    /// Chord Display Options
    @StateObject private var options = ChordDisplayOptions(defaults: defaults)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(options)
        }
    }
}
