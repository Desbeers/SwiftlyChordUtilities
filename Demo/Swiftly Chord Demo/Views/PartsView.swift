//
//  PartsView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyChordUtilities

struct DiagramSizeSliderView: View {

    @AppStorage("Diagram Width") private var size: Double = 300

    var body: some View {
        Slider(value: $size, in: 100...500)
            .frame(width: 200)
    }
}

struct AppearancePickerView: View {

    @AppStorage("Appearance") private var appearance: Appearance = .light

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
