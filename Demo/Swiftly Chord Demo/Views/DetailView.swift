//
//  DetailView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DetailView: View {

    @Binding var router: Router?

    @AppStorage("Appearance") private var appearance: Appearance = .light

    @Environment(\.colorScheme) var colorScheme

    /// Chord Display Options
    @EnvironmentObject var options: ChordDisplayOptions

    var body: some View {
        VStack(spacing: 0) {
            DisplayOptionsView()
            switch router {
            case .database:
                DatabaseView()
            case .define:
                DefineView()
            case .lookup:
                LookupView()
            case nil:
                Text("Welcome")
            }
        }
        .toolbar {
            AppearancePickerView()
                .pickerStyle(.segmented)
            DiagramSizeSliderView()
        }

        .preferredColorScheme(appearance == .print ? colorScheme : appearance == .dark ? .dark : .light)
    }
}
