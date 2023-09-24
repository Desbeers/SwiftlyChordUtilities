//
//  ChordDisplayOptions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyStructCache

/**
 An `Observable` Class with SwiftUI elements

 This class contains Toogles and Pickers you can add to your application to change the appearance of the chord diagrams.

 To use these elements, this Class must be added to your application as an `EnvironmentObject`

 - Note: The ``ChordDefinition/DisplayOptions`` will be preserved on disk.
 */
public final class ChordDisplayOptions: ObservableObject {
    /// Init the Class with optional defaults
    public init(defaults: ChordDefinition.DisplayOptions? = nil) {
        do {
            displayOptions = try Cache.get(key: "DisplayOptions", as: ChordDefinition.DisplayOptions.self)
        } catch {
            displayOptions = defaults ?? .init()
        }
        self.definition = ChordDefinition(name: "C", instrument: .guitarStandardETuning)!
    }

    /// All the ``ChordDefinition/DisplayOptions``
    @Published public var displayOptions: ChordDefinition.DisplayOptions {
        didSet {
            try? Cache.set(key: "DisplayOptions", object: displayOptions)
        }
    }

    /// All the values of a ``ChordDefinition``
    /// - Note: Used for editing a chord
    @Published public var definition: ChordDefinition

    /// The current instrument
    @AppStorage("Instrument") public var instrument: Instrument = .guitarStandardETuning
}
