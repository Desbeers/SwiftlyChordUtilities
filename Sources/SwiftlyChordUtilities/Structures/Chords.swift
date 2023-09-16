//
//  File.swift
//  
//
//  Created by Nick Berendsen on 16/09/2023.
//

import Foundation

public enum Chords {
    // Just a placeholder
}

public extension Chords {
    enum Database: String {
        case guitar = "GuitarChords"
    }
}

extension Chords {

    public static var guitar = Chords.readData(for: Chords.Database.guitar)

    private static func readData(for name: Chords.Database) -> [ChordDefinition] {
        do {
            if let fileURL = resourceURL(database: name) {
                let data = try Data(contentsOf: fileURL)
                let allChords = try JSONDecoder().decode([ChordDefinition].self, from: data)
                return allChords
            }
        } catch {
            print("There is no chord data:", error)
        }
        return []
    }

    public static func readDatabase( _ database: Chords.Database) -> String {
        do {
            if let fileURL = resourceURL(database: database) {
                return  try String(contentsOf: fileURL, encoding: .utf8)
            }
        } catch {
            print("There is no chord data:", error)
        }
        return ""
    }

    static func resourceURL(database: Chords.Database) -> URL? {
        var resourceURL = Bundle.module.resourceURL
        resourceURL?.appendPathComponent(database.rawValue)
        resourceURL?.appendPathExtension("chordsdb")
        return resourceURL
    }
}
