//
//  Collection+Extensions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {

    /// Avoid 'out of range' fatal errors
    /// - Note: Don't use `indices` because it will loop over all elements
    public subscript(safe index: Index) -> Iterator.Element? {
        (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}
