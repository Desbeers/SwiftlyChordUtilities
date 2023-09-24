//
//  PartsView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DiagramSizeSliderView: View {
    /// The current width of the diagram
    @AppStorage("Diagram Width") private var size: Double = 300
    /// The body of the `View`
    var body: some View {
        Slider(value: $size, in: 100...500)
            .frame(width: 200)
    }
}

struct AppearancePickerView: View {
    /// The current appearance
    @AppStorage("Appearance") private var appearance: Appearance = .light
    /// The body of the `View`
    var body: some View {
        Picker("Appearance:", selection: $appearance) {
            ForEach(Appearance.allCases, id: \.rawValue) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .frame(minWidth: 80)
    }
}
