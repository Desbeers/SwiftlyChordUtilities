//
//  File.swift
//  
//
//  Created by Nick Berendsen on 24/11/2022.
//

import Foundation
import SwiftyChords

extension Chords {
    typealias Root = Key
    typealias Quality = Suffix
}

extension Chords.Root {
    
    /// Convert a 'root' string to a 'root' enum
    /// - Parameter string: The root note
    /// - Returns: The root enum
    static func stringToEnum(string: String) -> Chords.Root {
        return Chords.Root(rawValue: string) ?? .c
    }
}

extension Chords.Quality {
    
    /// Convert a 'quality' string to a 'quality' enum
    /// - Parameter string: The quality
    /// - Returns: The quality string
    static func stringToEnum(string: String) -> Chords.Quality {
        switch string {
        case "69":
            return .sixNine
        default:
            return Chords.Quality(rawValue: string) ?? .major
        }
    }
    
    /// Convert an 'quality' enum to a 'quality' string
    var enumToString: String {
        switch self {
        case .sixNine:
            return "69"
        default:
            return self.rawValue
        }
    }
}
