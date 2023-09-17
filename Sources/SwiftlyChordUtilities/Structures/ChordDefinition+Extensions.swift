//
//  ChordDefinition+Extensions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI

public extension ChordDefinition {

    /// Format the name of the chord for display
    /// - Parameter options: The ``DisplayOptions``
    /// - Returns: A formatted string with the name of the chord
    func displayName(options: DisplayOptions) -> String {
        var name: String = ""

        if self.status == .unknown {
            /// We don't know anything about this chord
            name = self.name
        } else {
            switch options.rootDisplay {
            case .raw:
                name = self.root.rawValue
            case .accessible:
                name = self.root.display.accessible
            case .symbol:
                name = self.root.display.symbol
            }

            switch options.qualityDisplay {
            case .raw:
                name += "\(self.quality.rawValue)"
            case .short:
                name += "\(self.quality.display.short)"
            case .symbolized:
                name += "\(self.quality.display.symbolized)"
            case .altSymbol:
                name += "\(self.quality.display.altSymbol)"
            }
            /// Add an `*` for a custom chord as per ChordPro specifications
            if self.status == .custom || self.status == .customTransposed {
                name += "*"
            }
        }
        return name
    }
}

public extension ChordDefinition {

    /// Find chords matching the ``ChordDefinition`` notes
    var chordFinder: [ChordDefinition] {
        let uniqueNotes = components.filter { $0.note != .none} .uniqued(by: \.note).map(\.note)
        return findChordsFromNotes(notes: uniqueNotes, tuning: tuning)
    }
}

public extension ChordDefinition {

    /// Find the first matching chord from the database
    var firstChordFromDatabase: ChordDefinition? {

        guard
            let chord = Chords.guitar.first(where: {
                $0.root == self.root && $0.quality == self.quality }
            )
        else {
            return nil
        }
        return chord
    }
}
public extension ChordDefinition {

    /// Convert a ``ChordDefinition`` into a ChordPro `{define}`
    var define: String {
        var define = "{define: "
        define += root.rawValue + quality.display.short
        define += " base-fret "
        define += baseFret.description
        define += " frets "
        for fret in frets {
            define += "\(fret == -1 ? "x" : fret.description) "
        }
        define += "fingers"
        for finger in fingers {
            define += " \(finger)"
        }
        define += "}"
        return define
    }
}

public extension ChordDefinition {

    /// Play a ``ChordDefinition`` with MIDI
    /// - Parameter instrument: The `instrument` to use
    func play(instrument: Midi.Instrument = .acousticNylonGuitar) {
        Task {
            await MidiPlayer.shared.playChord(notes: self.components.compactMap(\.midi), instrument: instrument)
        }
    }
}
