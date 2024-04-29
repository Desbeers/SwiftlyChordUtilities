//
//  Array+ChordDefinition.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

public extension Array where Element == ChordDefinition {

    func roots() -> [Chord.Root] {
        return self.map(\.root)
    }

    func qualities() -> [Chord.Quality] {
        return self.map(\.quality)
    }

    func matching(root: Chord.Root) -> [ChordDefinition] {
        return self.filter { $0.root == root }
    }

    func matching(quality: Chord.Quality) -> [ChordDefinition] {
        return self.filter { $0.quality == quality }
    }

    func matching(bass: Chord.Root?) -> [ChordDefinition] {
        return self.filter { $0.bass == bass }
    }

    func matching(baseFret: Int) -> [ChordDefinition] {
        return self.filter { $0.baseFret == baseFret }
    }

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
