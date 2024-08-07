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

    /// Generate a random light Color
    static var randomLight: Color {
        return Color(
            red: .random(in: 0.6...1),
            green: .random(in: 0.6...1),
            blue: .random(in: 0.6...1)
        )
    }
}
