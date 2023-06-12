//
//  Regex.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import RegexBuilder
import SwiftyChords

/// The regex for a `chord` string
///
/// It will parse the chord to find the `root` and optional `quality`
///
///     /// ## Examples
///
///     Am -> root: Am, quality: m
///     Dsus4 -> root: D, quality: sus4
///
public let chordRegex = Regex {
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

/// The regex for a `define` directive
///
///     /// ## Example
///
///     {define: Bes base-fret 1 frets 1 1 3 3 3 1 fingers 1 1 2 3 4 1}
///
///     Key: Bes
///     Definition: base-fret 1 frets 1 1 3 3 3 1 fingers 1 1 2 3 4 1
///
public let defineRegex = Regex {
    TryCapture {
        OneOrMore {
            CharacterClass(
                .anyOf("#b"),
                (.word),
                (.digit)
            )
        }
    } transform: {
        $0.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    TryCapture {
        OneOrMore(.any)
    } transform: {
        $0.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
