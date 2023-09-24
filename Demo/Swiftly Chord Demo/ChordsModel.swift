//
//  ChordsModel.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import Foundation
import SwiftlyChordUtilities

/// The class with all the chords of the selected instrument
final class ChordsModel: ObservableObject {
    @Published var chords: [ChordDefinition] = []
}
