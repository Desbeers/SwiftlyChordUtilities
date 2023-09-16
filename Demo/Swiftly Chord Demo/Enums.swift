//
//  Enums.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI

enum Appearance: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case print = "Print"

    var colors: (primary: Color, secondary: Color) {
        switch self {
        case .light:
             (Color.randomDark, Color.windowBackground)
        case .dark:
            (Color.randomLight, Color.windowBackground)
        case .print:
            (Color.black, Color.white)
        }
    }
}

enum Status {
    case loading
    case ready
    case empty
}
