//
//  ChordPosition+Extensions.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import SwiftyChords

public extension ChordPosition {

    var notes: [Note] {
        var notes: [Note] = []
        for note in self.midi {
            let key = valueToNote(value: (note), scale: self.key)
            notes.append(Note(note: key))
        }
        return notes
    }

    struct Note: Identifiable, Hashable {
        public let id = UUID()
        public var note: Chords.Key
    }
}

public extension ChordPosition {
    var chordFinder: [Chord] {
        findChordsFromNotes(notes: notes.map({$0.note}).unique(by: {$0}))
    }
}

public extension ChordPosition {

    /// The full name of the chord
    var name: String {
        return "\(key.rawValue)\(suffix.rawValue)"
    }
}

public extension ChordPosition {

    /// Convert a `ChordPosition` into a ChordPro `{define}`
    var define: String {
        var define = "{define: "
        define += key.rawValue + suffix.rawValue
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

public extension ChordPosition {

    /// Play a chord with MIDI
    /// - Parameter instrument: The `instrument` to use
    func play(instrument: MidiPlayer.Instrument = .acousticNylonGuitar) {
        Task {
            await MidiPlayer.shared.playNotes(notes: self.midi, instument: instrument)
        }
    }
}
