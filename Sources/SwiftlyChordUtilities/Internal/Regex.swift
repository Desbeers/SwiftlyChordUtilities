//
//  Regex.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import RegexBuilder

// MARK: Regex to parse a chord name

/// The regex for a `chord` string
///
/// It will parse the chord to find the `root` and optional `quality`
///
///     /// ## Examples
///
///     Am -> root: Am, quality: m
///     Dsus4 -> root: D, quality: sus4
///
let chordRegex = Regex {
    /// The root
    rootRegex
    /// The optional quality
    Optionally {
        Capture {
            OneOrMore {
                CharacterClass(
                    (.word),
                    (.digit),
                    .anyOf("#?")
                )
            }
        } transform: { quality in
            /// Try to find the name of the quality
            for name in Chord.Quality.allCases {
                if name.name.contains(String(quality)) {
                    return name
                }
            }
            /// The quality is unknown
            return Chord.Quality.unknown
        }
    }
    Optionally {
        "/"
        rootRegex
    }
}

// MARK: Regex to parse a define

let defineRegex = Regex {
    /// Capture the name
    Capture {
        OneOrMore {
            CharacterClass(
                .anyOf("#b/+?"),
                (.word),
                (.digit)
            )
        }
    } transform: { name in
        String(name)
    }
    /// Capture the base-fret
    Optionally {
        " base-fret "
        Capture {
            OneOrMore(.digit)
        } transform: { baseFret in
            Int(baseFret) ?? 0
        }
    }
    /// Capture the frets
    Optionally {
        " frets "
        Capture {
            OneOrMore {
                CharacterClass(
                    .anyOf("x"),
                    (.digit),
                    (.whitespace)
                )
            }
        } transform: { frets in
              String(frets).trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    /// Capture the fingers
    Optionally {
        "fingers "
        Capture {
            OneOrMore {
                CharacterClass(
                    (.digit),
                    (.whitespace)
                )
            }
        } transform: { fingers in
            return String(fingers).trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

// MARK: Regex to parse the root of a chord

let rootRegex = Capture {
    OneOrMore {
        CharacterClass(
            .anyOf("CDEFGABb#")
        )
    }
} transform: { root in
    Chord.Root(rawValue: String(root)) ?? Chord.Root.none
}
