//
//  ChordDefinition+transpose.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

public extension ChordDefinition {

    mutating func transpose(transpose: Int, scale: Chord.Root) {
        if self.status == .custom {
            self.status = .customTransposed
        } else {
            let root = transposeNote(note: self.root, transpose: transpose, scale: scale)
            if let chord =  Chords.guitar.matching(root: root).matching(quality: self.quality).first {
                self = chord
                self.status = .transposed
            }
        }
    }
}
