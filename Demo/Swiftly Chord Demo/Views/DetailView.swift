//
//  DetailView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DetailView: View {
    /// The selected router item
    @Binding var router: Router?
    /// The current appearance
    @AppStorage("Appearance") private var appearance: Appearance = .light
    /// The current color scheme
    @Environment(\.colorScheme) var colorScheme
    /// Chord Display Options
    @Environment(ChordDisplayOptions.self) private var chordDisplayOptions
    /// The body of the `View`
    var body: some View {
        VStack(spacing: 0) {
            switch router {
            case .database:
                DatabaseView()
            case .create:
                CreateView()
            case .define:
                DefineView()
            case .lookup:
                LookupView()
            case nil:
                Text("Welcome")
            }
        }
        .toolbar {
            chordDisplayOptions.instrumentPicker
            AppearancePickerView()
                .pickerStyle(.segmented)
            DiagramSizeSliderView()
        }
        .preferredColorScheme(appearance == .print ? colorScheme : appearance == .dark ? .dark : .light)
    }
}
