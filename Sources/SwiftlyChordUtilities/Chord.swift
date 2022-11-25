//
//  Chord.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import SwiftyChords

/// Struct to handle a chord
public struct Chord: Identifiable {
    
    /// # Properties
    
    /// The ID of the chord
    public var id: String {
        chord
    }
    /// The chord in the UI
    public var display: String {
        var display = "\(root.display.symbol)"
        if quality.name != .major {
            display += " \(quality.name.display.symbolized)"
        }
        if let on {
            display += Chords.Suffix(rawValue: "/\(on.rawValue)")?.display.symbolized ?? "/?"
        }
        return display
    }
    /// The name of the chord, as found
    public var name: String {
        var name = root.rawValue
        if let on {
            name += "/\(on.rawValue)"
        } else {
            name += quality.name.rawValue
        }
        return name
    }
    /// Name of the chord. (e.g. C, Am7, F#m7-5/A)
    let chord: String
    /// The root note of the chord. (e.g. C, A, F#)
    public var root: Chords.Root
    /// The quality of the chord. (e.g. maj, m7, m7-5)
    var quality: Quality
    /// The appended notes on the chord
    let appended: [String]
    /// The base note of an optional 'slash' chord
    var on: Chords.Root?
    
    /// # Init
    
    /// Init the chord struct from a string
    init(chord: String) {
        /// Parse the chord string
        let parse = parse(chord: chord)
        /// Set the properties
        self.chord = chord
        self.root = parse.root
        self.quality = parse.quality
        self.appended = parse.appended
        self.on = parse.on
        /// Append optional 'slash' chord
        self.appendOnChord()
    }
    
    /// Init the chord with known components
    init(chord: String, root: Chords.Root, quality: Quality, on: Chords.Key? = nil) {
        self.chord = chord
        self.root = root
        self.quality = quality
        self.appended = []
        self.on = on
    }
    
    /// # Fuctions
    
    /// Transpose the chord
    /// - Parameters:
    ///   - trans: Transpose key
    ///   - scale: Key scale
    public mutating func transpose(transpose: Int, scale: Chords.Key = .c) {
        root = transposeNote(note: root, transpose: transpose, scale: scale)
        if let on {
            self.on = transposeNote(note: on, transpose: transpose, scale: scale)
        }
    }
    
    /// Return the component notes of chord
    /// - Returns: The notes as [String]
    public func components() -> [Chords.Key] {
        return quality.getComponents(root: root, visible: true)
    }
    
    /// Append the 'on' chord, if any
    private mutating func appendOnChord() {
        if let on {
            quality.appendOnChord(on, root)
        }
    }
}
