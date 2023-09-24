//
//  Chords.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

/// Bits and pieces to get chord definitions
public enum Chords {
    // Just a placeholder
}

extension Chords {

    // MARK: Public

    /// Get all the guitar chords in a ``ChordDefinition`` array
    public static var guitar = Chords.importDefinitions(instrument: .guitarStandardETuning)

    /// Get all the guitalile chords in a ``ChordDefinition`` array
    public static var guitalele = Chords.importDefinitions(instrument: .guitaleleStandardATuning)

    /// Get all the ukulele chords in a ``ChordDefinition`` array
    public static var ukulele = Chords.importDefinitions(instrument: .ukuleleStandardGTuning)

    /// Get all the database definitions in JSON format
    /// - Parameter instrument: The ``Instrument``
    /// - Returns: The ``Database`` in JSON format
    public static func jsonDatabase(instrument: Instrument) -> String {
        Bundle.module.json(from: instrument.database)
    }
    
    /// Import a ``Database`` in JSON format to a ``ChordDefinition`` array
    /// - Parameter database: The ``Database`` in JSON format
    /// - Returns: A ``ChordDefinition`` array
    public static func importDatabase(database: String) -> [ChordDefinition] {
        importDefinitions(database: database)
    }
    
    /// Export a ``ChordDefinition`` array to a ``Database`` in JSON format
    /// - Parameter definitions: A ``ChordDefinition`` array
    /// - Returns: The ``Database`` in JSON format
    public static func exportDatabase(definitions: [ChordDefinition]) -> String {
        exportDefinitions(definitions: definitions)
    }

    // MARK: Private

    /// Import a definition database from a JSON database file
    /// - Parameter database: The ``Instrument``
    /// - Returns: An array of ``ChordDefinition``
    static func importDefinitions(instrument: Instrument) -> [ChordDefinition] {
        let database = Bundle.module.decode(Database.self, from: instrument.database)
        return importDatabase(database: database)
    }

    /// Import a definition database from a JSON string
    /// - Parameter database: The databse in JSON format
    /// - Returns: An array of ``ChordDefinition``
    static func importDefinitions(database: String) -> [ChordDefinition] {
        let decoder = JSONDecoder()
        do {
            let data = database.data(using: .utf8)!
            let database =  try decoder.decode(Database.self, from: data)
            return importDatabase(database: database)
        } catch {
            print(error)
            return []
        }
    }

    static func exportDefinitions(definitions: [ChordDefinition]) -> String {
        guard
            /// The first definition is needed to find the instrument
            let firstDefinition = definitions.first
        else{
            return("No definitions")
        }
        let definitions = definitions.map(\.define).sorted()

        let export = Database(
            instrument: firstDefinition.instrument,
            definitions: definitions
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let encodedData = try encoder.encode(export)
            let jsonString = String(
                data: encodedData,
                encoding: .utf8
            )
            return jsonString ?? "error"
        } catch {
            return "error"
        }
    }

    static func importDatabase(database: Database) -> [ChordDefinition] {
        var definitions: [ChordDefinition] = []
        for definition in database.definitions {
            if let result = ChordDefinition(definition: definition, instrument: database.instrument) {
                definitions.append(result)
            }
        }
        return definitions
    }

    static func parseDefinitions(instrument: Instrument, definitions: String) -> [ChordDefinition] {
        definitions.split(separator: "\n", omittingEmptySubsequences: true).map { definition in
            if let result = ChordDefinition(definition: String(definition), instrument: instrument) {
                return result
            }
            return ChordDefinition(unknown: "Unknown", instrument: instrument)
        }
    }

    static func getAllChordsForInstrument(instrument: Instrument) -> [ChordDefinition] {
        switch instrument {
        case .guitarStandardETuning:
            Chords.guitar
        case .guitaleleStandardATuning:
            Chords.guitalele
        case .ukuleleStandardGTuning:
            Chords.ukulele
        }
    }
}
