//
//  ChordDisplayOptions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI
import SwiftlyStructCache

/// An `Observable` Class with SwiftUI elements
///
/// This class contains SwiftUI Toggles and Pickers you can add to your application to change the appearance of the chord diagrams.
///
/// - Note: The ``ChordDefinition/DisplayOptions`` will be preserved on disk.
@Observable
public final class ChordDisplayOptions {
    /// Init the Class with optional defaults
    public init(defaults: ChordDefinition.DisplayOptions? = nil) {
        do {
            displayOptions = try Cache.get(key: "DisplayOptions", as: ChordDefinition.DisplayOptions.self)
        } catch {
            displayOptions = defaults ?? .init()
        }
        // swiftlint:disable:next force_unwrapping
        self.definition = ChordDefinition(name: "C", instrument: .guitarStandardETuning)!
    }

    /// All the ``ChordDefinition/DisplayOptions``
    public var displayOptions: ChordDefinition.DisplayOptions {
        didSet {
            try? Cache.set(key: "DisplayOptions", object: displayOptions)
        }
    }

    /// All the values of a ``ChordDefinition``
    /// - Note: Used for editing a chord
    public var definition: ChordDefinition
}
