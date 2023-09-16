//
//  ChordDefinition+DisplayOptions.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import Foundation

extension ChordDefinition {

    /// The structure for display options passed to the ``ChordDefinitionView``
    public struct DisplayOptions: Codable, Equatable {
        /// Init the structure with default values
        public init(
            showName: Bool = true,
            showNotes: Bool = false,
            showPlayButton: Bool = false,
            rootDisplay: Display.Root = .symbol,
            qualityDisplay: Display.Quality = .symbolized,
            showFingers: Bool = true,
            mirrorDiagram: Bool = false,
            instrument: Midi.Instrument = .acousticSteelGuitar
        ) {
            self.showName = showName
            self.showPlayButton = showPlayButton
            self.showNotes = showNotes
            self.rootDisplay = rootDisplay
            self.qualityDisplay = qualityDisplay
            self.showFingers = showFingers
            self.mirrorDiagram = mirrorDiagram
            self.instrument = instrument

        }
        /// Show the name in the chord shape
        public var showName: Bool
        /// Show the notes of the chord
        public var showNotes: Bool
        /// Show a button to play the chord with MIDI
        public var showPlayButton: Bool
        /// Display of the root value
        public var rootDisplay: Display.Root
        /// Display of the quality value
        public var qualityDisplay: Display.Quality
        /// Show the finger position on the diagram
        public var showFingers: Bool
        /// Mirror the chord diagram for lefthanded users
        public var mirrorDiagram: Bool
        /// The instrument to use for playing the chord with MIDI
        public var instrument: Midi.Instrument

        /// Display options for the chord name
        public enum Display {
            /// Root display options
            public enum Root: String, Codable, CaseIterable {
                /// Display the raw value
                case raw
                case accessible
                case symbol
            }
            /// Quality display options
            public enum Quality: String, Codable, CaseIterable {
                /// Display the raw value
                case raw
                case short
                case symbolized
                case altSymbol
            }
        }
    }
}

//extension ChordDefinition.DisplayOptions: RawRepresentable {
//    public init?(rawValue: String) {
//        guard let data = rawValue.data(using: .utf8),
//            let result = try? JSONDecoder().decode(ChordDefinition.DisplayOptions.self, from: data)
//        else {
//            return nil
//        }
//        self = result
//    }
//
//    public var rawValue: String {
//        guard let data = try? JSONEncoder().encode(self),
//            let result = String(data: data, encoding: .utf8)
//        else {
//            return "[]"
//        }
//        return result
//    }
//}
