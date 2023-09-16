//
//  Color+Extensions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI

public extension Color {

    /// Generate a random dark Color
    static var randomDark: Color {
        return Color(
            red: .random(in: 0...0.6),
            green: .random(in: 0...0.6),
            blue: .random(in: 0...0.6)
        )
    }

    static var randomLight: Color {
        return Color(
            red: .random(in: 0.6...1),
            green: .random(in: 0.6...1),
            blue: .random(in: 0.6...1)
        )
    }

    static var windowLabel: Color {
#if os(macOS)
        return Color(nsColor: .labelColor)
#else
        return Color(uiColor: .label)
#endif
    }

    static var windowBackground: Color {
#if os(macOS)
        return Color(nsColor: .windowBackgroundColor)
#else
        return Color(uiColor: .systemBackground)
#endif
    }
}
