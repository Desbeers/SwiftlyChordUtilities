//
//  Regex.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import RegexBuilder

/// The regex for a `chord` string
///
/// It will parse the chord to find the `root` and optional `quality`
///
///     /// ## Examples
///
///     Am -> root: Am, quality: nil
///     Dsus4 -> root: D, quality: sus4
///
let chordRegex = Regex {
    /// The root
    Capture {
        OneOrMore {
            CharacterClass(
                .anyOf("CDEFGABb#")
            )
        }
    }
    /// The optional quality
    Optionally {
        Capture {
            OneOrMore(.any)
        }
    }
}

let inversionRegex = Regex {
    "/"
    Capture {
        OneOrMore(("0"..."9"))
    }
    Capture {
        ZeroOrMore(.any)
    }
}

let slashRegex = Regex {
    /// The slash
    Capture {
        OneOrMore("/")
    }
    /// The following chord
    Capture {
        OneOrMore(.any)
    }
}
