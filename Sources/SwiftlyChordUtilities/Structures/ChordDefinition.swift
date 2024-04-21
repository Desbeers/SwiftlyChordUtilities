//
//  ChordDefinition.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

/// The structure of a chord definition
public struct ChordDefinition: Equatable, Codable, Identifiable, Hashable {

    // MARK: Database items

    /// The ID of the chord
    public var id: UUID
    /// The fret positions of the chord
    public var frets: [Int]
    /// The finger positions of the chord
    public var fingers: [Int]
    /// The base fret of the chord
    public var baseFret: Int
    /// The root of the chord
    public var root: Chord.Root
    /// The quality of the chord
    public var quality: Chord.Quality

    // MARK: Other items

    /// The name of the chord
    public var name: String

    /// The fingers you have to bar for the chord
    /// - Note: A calculated value by the init
    public var barres: [Int]

    /// The instrument of the chord
    public var instrument: Instrument

    /// The appended notes on the chord
    var appended: [String] = []
    /// The base note of an optional 'slash' chord
    public var bass: Chord.Root?
    /// The components of the chord definition
    public var components: [Chord.Component] = []
    /// The status of the chord
    public var status: Chord.Status

    // MARK: Coding keys

    /// The coding keys
    /// - Note: Only those items will be in the database
    enum CodingKeys: CodingKey {
        case id
        case frets
        case fingers
        case baseFret
        case root
        case quality
        case bass
    }
    


    /// Custom encoder for the ``ChordDefinition``
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<ChordDefinition.CodingKeys> = encoder.container(keyedBy: ChordDefinition.CodingKeys.self)
        
        try container.encode(self.id, forKey: ChordDefinition.CodingKeys.id)
        try container.encode(self.frets, forKey: ChordDefinition.CodingKeys.frets)
        try container.encode(self.fingers, forKey: ChordDefinition.CodingKeys.fingers)
        try container.encode(self.baseFret, forKey: ChordDefinition.CodingKeys.baseFret)
        try container.encode(self.root, forKey: ChordDefinition.CodingKeys.root)
        try container.encode(self.quality, forKey: ChordDefinition.CodingKeys.quality)
        try container.encode(self.bass, forKey: ChordDefinition.CodingKeys.bass)
    }
}
