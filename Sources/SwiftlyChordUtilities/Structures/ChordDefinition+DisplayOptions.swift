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
            instrument: Midi.Instrument = .acousticSteelGuitar,
            tuning: Tuning = .guitarStandardETuning
        ) {
            self.showName = showName
            self.showPlayButton = showPlayButton
            self.showNotes = showNotes
            self.rootDisplay = rootDisplay
            self.qualityDisplay = qualityDisplay
            self.showFingers = showFingers
            self.mirrorDiagram = mirrorDiagram
            self.instrument = instrument
            self.tuning = tuning
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
        /// The tuning of the instrument
        public var tuning: Tuning

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
