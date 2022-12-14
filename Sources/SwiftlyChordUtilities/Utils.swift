//
//  Utils.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation
import SwiftyChords

/// Get index value of a note
func noteToValue(note: Chords.Root) -> Int {
    guard let value = noterValueDict[note] else {
        return 0
    }
    return value
}

/// Return note by index in a scale
func valueToNote(value: Int, scale: Chords.Root = .c) -> Chords.Key {
    let value = value < 0 ? (12 + value) : (value % 12)
    guard let value = scaleValueDict[scale]?[value] else {
        return .c
    }
    return value
}

/// Transpose the chord
/// - Parameters:
///   - trans: Transpose key
///   - scale: Key scale
func transposeNote(note: Chords.Key, transpose: Int, scale: Chords.Key = .c) -> Chords.Key {
    let value = noteToValue(note: note) + transpose
    return valueToNote(value: value, scale: scale)
}
