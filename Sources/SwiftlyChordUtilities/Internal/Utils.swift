//
//  Utils.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// Get index value of a note
func noteToValue(note: Chord.Root) -> Int {
    guard let value = noterValueDict[note] else {
        return 0
    }
    return value
}

/// Return note by index in a scale
func valueToNote(value: Int, scale: Chord.Root) -> Chord.Root {
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
func transposeNote(note: Chord.Root, transpose: Int, scale: Chord.Root = .c) -> Chord.Root {
    let value = noteToValue(note: note) + transpose
    return valueToNote(value: value, scale: scale)
}

/// Calculate the chord components
func fretsToComponents(
    root: Chord.Root,
    frets: [Int],
    baseFret: Int,
    instrument: Instrument
) -> [Chord.Component] {
    var components: [Chord.Component] = []
    if !frets.isEmpty {
        for string in instrument.strings {
            var fret = frets[string]
            /// Don't bother with ignored frets
            if fret == -1 {
                components.append(Chord.Component(note: .none, midi: nil))
            } else {
                /// Add base fret if the fret is not 0 and the offset
                fret += instrument.offset[string] + (fret == 0 ? 1 : baseFret) + 40
                let key = valueToNote(value: fret, scale: root)
                components.append(Chord.Component(note: key, midi: fret))
            }
        }
    }
    return components
}

func fingersToBarres(fingers: [Int]) -> [Int] {
    var barres: [Int] = []
    /// set the barres but use not '0' as barres
    let mappedItems = fingers.map { ($0, 1) }
    let counts = Dictionary(mappedItems, uniquingKeysWith: +)
    for (key, value) in counts where value > 1 && key != 0 {
        barres.append(key)
    }
    return barres
}
