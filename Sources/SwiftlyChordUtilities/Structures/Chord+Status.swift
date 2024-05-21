//
//  Chord+Status.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension Chord {

    /**
     The status of a chord

     The ``ChordDefinitionView`` wants to know the status of the chord

     - An unknown chord can not show a diagram
     - A custom chord that is transposed  can not show a diagram
     */
    public enum Status: String, Sendable {
        /// A standard chord from the database
        case standard
        /// A transposed chord
        case transposed
        /// A custom defined chord
        case custom
        /// A custom defined chord that is transposed
        case customTransposed
        /// An unknown chord
        case unknown
    }
}
