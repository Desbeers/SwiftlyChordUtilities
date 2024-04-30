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

    // MARK: Helper functions

    /// Check if fingers should be barred
    /// - Parameters:
    ///   - fret: The frest that might have a bar
    ///   - mirrorDiagram: Bool if the diagram should be mirrored for left-handed
    /// - Returns: The barre dimensions or nil if not a barre
    // swiftlint:disable:next large_tuple
    public func checkBarre(fret: Int, mirrorDiagram: Bool) -> (finger: Int, startIndex: Int, endIndex: Int, length: Int)? {
        let frets = mirrorDiagram ? self.frets.reversed() : self.frets
        let fingers = mirrorDiagram ? self.fingers.reversed() : self.fingers
        var isBarre: Bool = false
        var finger: Int = 0
        for column in frets.indices {
            if frets[safe: column] == fret && barres.contains(fingers[safe: column] ?? -1) {
                isBarre = true
                finger = fingers[safe: column] ?? 0
            }
        }
        switch isBarre {
        case true:
            let bar = calculateBar(fret: fret, finger: finger)
            return (finger, bar.startIndex, bar.endIndex, bar.length)
        case false:
            return nil
        }

        /// Helper function to calculate the bar size
        /// - Parameters:
        ///   - fret: The fret with the bar
        ///   - finger: The fingers of the chord; adjusted for left-handed if needed
        /// - Returns: The start, end and lenght of the bar
        // swiftlint:disable:next large_tuple
        func calculateBar(fret: Int, finger: Int) -> (startIndex: Int, endIndex: Int, length: Int) {
            /// Draw barre behind all frets that are above the barre chord
            var startIndex = (frets.firstIndex { $0 == fret } ?? 0)
            let barreFretCount = frets.filter { $0 == fret }.count
            var length = 0

            for index in startIndex..<frets.count {
                let dot = frets[index]
                if dot >= fret {
                    length += 1
                } else if dot < fret && length < barreFretCount {
                    length = 0
                    startIndex = index + 1
                } else {
                    break
                }
            }
            let endIndex = startIndex + length
            return (startIndex, endIndex, length)
        }
    }

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
