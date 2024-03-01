//
//  ChordsModel.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import Foundation
import SwiftlyChordUtilities

/// The class with all the chords of the selected instrument
@Observable
final class ChordsModel {
    var chords: [ChordDefinition] = []
}
