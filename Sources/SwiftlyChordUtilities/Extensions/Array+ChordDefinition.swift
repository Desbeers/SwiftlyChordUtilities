//
//  Array+ChordDefinition.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

public extension Array where Element == ChordDefinition {

    /// Get all roots
    /// - Returns: All the roots
    func roots() -> [Chord.Root] {
        return self.map(\.root)
    }

    /// Get all qualities
    /// - Returns: All the qualities
    func qualities() -> [Chord.Quality] {
        return self.map(\.quality)
    }

    /// Find all chord definitions matching a root note
    /// - Parameter root: The root note
    /// - Returns: All matching chord definitions
    func matching(root: Chord.Root) -> [ChordDefinition] {
        return self.filter { $0.root == root }
    }

    /// Find all chord definitions matching a quality
    /// - Parameter quality: The quality
    /// - Returns: All matching chord definitions
    func matching(quality: Chord.Quality) -> [ChordDefinition] {
        return self.filter { $0.quality == quality }
    }

    /// Find all chord definitions matching a bass note
    /// - Parameter bass: Te bass note
    /// - Returns: All matching chord definitions
    func matching(bass: Chord.Root?) -> [ChordDefinition] {
        return self.filter { $0.bass == bass }
    }

    /// Find all chord definitions matching a base fret
    /// - Parameter baseFret: The base fret
    /// - Returns: All matching chord definitions
    func matching(baseFret: Int) -> [ChordDefinition] {
        return self.filter { $0.baseFret == baseFret }
    }

    /// Find all chord definitions matching a chord group
    /// - Parameter group: The group
    /// - Returns: All matching chord definitions
    func matching(group: Chord.Group) -> [ChordDefinition] {
        return self.filter { $0.quality.group == group }
    }
}

extension Array {

    /// Get all combinations of an array
    ///  - Note: Used to get all chord notes combinations in `getChordComponents`
    var combinationsWithoutRepetition: [[Element]] {
        guard !isEmpty else { return [[]] }
        return Array(self[1...]).combinationsWithoutRepetition.flatMap { [$0, [self[0]] + $0] }
    }
}
