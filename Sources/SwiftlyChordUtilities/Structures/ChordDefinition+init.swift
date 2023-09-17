//
//  ChordDefinition+init.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

public extension ChordDefinition {

    /// Init the ``ChordDefinition`` from the decoder
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ChordDefinition.CodingKeys> = try decoder.container(keyedBy: ChordDefinition.CodingKeys.self)
        /// Database values
        self.id = try container.decode(UUID.self, forKey: ChordDefinition.CodingKeys.id)
        self.frets = try container.decode([Int].self, forKey: ChordDefinition.CodingKeys.frets)
        self.fingers = try container.decode([Int].self, forKey: ChordDefinition.CodingKeys.fingers)
        self.baseFret = try container.decode(Int.self, forKey: ChordDefinition.CodingKeys.baseFret)
        self.root = try container.decode(Chord.Root.self, forKey: ChordDefinition.CodingKeys.root)
        self.quality = try container.decode(Chord.Quality.self, forKey: ChordDefinition.CodingKeys.quality)
        /// Calculated values
        self.name = "\(root.rawValue)\(quality.rawValue)"
        self.barres = fingersToBarres(fingers: fingers)
        self.slashNote = self.quality.slashNote
        self.components = fretsToComponents(root: root, frets: frets, baseFret: baseFret, tuning: .guitarStandardETuning)
        self.status = .standard
        self.tuning = .guitarStandardETuning
    }

    /// Init the ``ChordDefinition`` with all known values
    init(
        id: UUID,
        name: String,
        frets: [Int],
        fingers: [Int],
        baseFret: Int,
        root: Chord.Root,
        quality: Chord.Quality,
        tuning: Tuning,
        status: Chord.Status = .custom
    ) {
        self.id = id
        self.frets = frets
        self.fingers = fingers
        self.baseFret = baseFret
        self.root = root
        self.quality = quality
        self.name = name
        self.tuning = tuning
        self.status = status
        /// Calculated values
        self.components = fretsToComponents(root: root, frets: frets, baseFret: baseFret, tuning: tuning)
        self.barres = fingersToBarres(fingers: fingers)
        self.slashNote = self.quality.slashNote
    }
    
    /// Init the ``ChordDefinition`` with a **ChordPro** definition
    init?(definition: String, tuning: Tuning) {
        /// Parse the chord definition
        if let definition = SwiftlyChordUtilities.define(from: definition, tuning: tuning) {
            /// Set the properties
            self.id = UUID()
            self.frets = definition.frets
            self.fingers = definition.fingers
            self.baseFret = definition.baseFret
            self.root = definition.root
            self.quality = definition.quality
            self.name = definition.name
            self.tuning = tuning
            self.status = .custom
            /// Calculated values
            self.components = fretsToComponents(root: root, frets: frets, baseFret: baseFret, tuning: tuning)
            self.barres = fingersToBarres(fingers: fingers)
            self.slashNote = self.quality.slashNote

        } else {
            return nil
        }
    }
    
    /// Init the ``ChordDefinition`` with the name of a chord
    init?(name: String, tuning: Tuning) {
        /// Parse the chord name
        let rootAndQuality = findRootAndQuality(chord: name)
        guard
            let root = rootAndQuality.root,
            let quality = rootAndQuality.quality,
            let chord = Chords.guitar.matching(root: root).matching(quality: quality).first
        else {
            return nil
        }
        /// Set the properties
        self.id = chord.id
        self.frets = chord.frets
        self.fingers = chord.fingers
        self.baseFret = chord.baseFret
        self.root = chord.root
        self.quality = chord.quality
        self.name = name
        self.tuning = tuning
        self.status = .standard
        /// Calculated values
        self.components = fretsToComponents(root: root, frets: frets, baseFret: baseFret, tuning: tuning)
        self.barres = fingersToBarres(fingers: fingers)
        self.slashNote = self.quality.slashNote
    }

    /// Init the ``ChordDefinition`` with an unknown chord
    init(unknown: String) {
        /// Set the properties
        self.id = UUID()
        self.frets = []
        self.fingers = []
        self.baseFret = 0
        self.root = .c
        self.quality = .major
        self.name = unknown
        self.tuning = .guitarStandardETuning
        self.status = .unknown
        /// Calculated values
        self.components = []
        self.barres = []
        self.slashNote = nil
    }
}
