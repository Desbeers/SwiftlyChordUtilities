//
//  CustomChord.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import SwiftyChords

// MARK: Custom Chords

/// A custom chord in 'SwiftyChords`
public struct CustomChord: Equatable {
    public init(id: UUID, frets: [Int], fingers: [Int], baseFret: Int, barres: [Int], bar: Int = 0, capo: Bool? = nil, root: Chords.Root, quality: Chords.Quality) {
        self.id = id
        self.frets = frets
        self.fingers = fingers
        self.baseFret = baseFret
        self.barres = barres
        self.bar = bar
        self.capo = capo
        self.root = root
        self.quality = quality
    }
    
    public var id: UUID
    public var frets: [Int]
    public var fingers: [Int]
    public var baseFret: Int
    public var barres: [Int]
    public var bar: Int
    public var capo: Bool?
    public var midi: [Midi.Note] {
        return Midi.values(values: self)
    }
    public var root: Chords.Root
    public var quality: Chords.Quality
}
