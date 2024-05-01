//
//  Chord+Barre.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen

import Foundation

extension Chord {
    
    /// The structure of a chord barre
    public struct Barre: Equatable, Codable, Hashable  {
        /// The finger for the barre
        public var finger: Int = 0
        /// the fret for the barr
        public var fret: Int = 0
        /// The first string to bar
        public var startIndex: Int = 0
        /// The last string to bar
        public var endIndex: Int = 0
        /// The calculated lenght
        public var length: Int {
            endIndex - startIndex
        }
    }
}
