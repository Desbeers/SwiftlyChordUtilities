//
//  Analizer.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// Find the root and quality of a named chord
/// - Parameter chord: The name of the chord
/// - Returns: The root and quality
func findRootAndQuality(chord: String) -> (root: Chord.Root?, quality: Chord.Quality?) {

    var root: Chord.Root?
    var quality: Chord.Quality?
    if let match = chord.wholeMatch(of: chordRegex) {
        let chordRoot = String(match.1)
        root = Chord.Root(rawValue: chordRoot)
        //var chordQuality = Chords.Quality.major.rawValue
        if let matchSuffix = match.2 {

            var chordQuality = String(matchSuffix)
            /// ChordPro suffix are not always the suffixes in the database...
            switch chordQuality {
            case "m":
                chordQuality = "minor"
            default:
                break
            }
            quality = Chord.Quality(rawValue: chordQuality)
        } else {
            quality = Chord.Quality.major
        }
    }
    return (root, quality)
}

/// Find possible chords consisted from notes
/// - Parameter notes: List of note arranged from lower note. ex ["C", "Eb", "G"]
/// - Returns: A ``ChordDefinition``array
func findChordsFromNotes(notes: [Chord.Root], tuning: Tuning) -> [ChordDefinition] {
    if notes.isEmpty {
        return []
    }
    let root = notes[0]
    var rootAndPositions: [Chord.Root: [Int]] = [:]
    for rotatedNotes in getAllRotatedNotes(notes: notes) {
        let rotatedRoot = rotatedNotes[0]
        var notes: [Int] = []
        let notePositions = notesToPositions(notes: rotatedNotes, root: rotatedRoot)
        for note in notePositions {
            notes.append(note % 12)
        }
        rootAndPositions[rotatedRoot] = notes.sorted()
    }
    var chords: [ChordDefinition] = []
    for (tempRoot, positions) in rootAndPositions {
        if let qualities = findQualitiesFromComponents(components: positions) {
            for quality in qualities {
                var on: Chord.Root?
                if tempRoot != root {
                    on = root
                }
                var qualityEnum = quality.name
                if let on {
                    qualityEnum = on.slashQuality
                }
                chords.append(
                    ChordDefinition(
                        id: UUID(),
                        name: "\(root.rawValue)\(quality.name.rawValue)",
                        frets: [],
                        fingers: [],
                        baseFret: 0,
                        root: tempRoot,
                        quality: qualityEnum,
                        tuning: tuning,
                        status: .standard
                    )
                )
            }
        }
    }
    return chords.sorted(using: KeyPathComparator(\.name))
}

/// Get all rotated notes
///
/// [A,C,E]) -> [[A,C,E],[C,E,A],[E,A,C]]
///
/// - Parameter notes: The list of notes
/// - Returns: The possible chords
func getAllRotatedNotes(notes: [Chord.Root]) -> [[Chord.Root]] {
    var notesList: [[Chord.Root]] = []
    for index in 0..<notes.count {
        notesList.append(Array(notes[index...] + notes[..<index]))
    }
    // print("----")
    // print(notesList)
    return notesList
}

/// Get notes positions from the root note
/// - Parameters:
///   - notes: List of notes
///   - root: Root note
/// - Returns: List of note positions
func notesToPositions(notes: [Chord.Root], root: Chord.Root) -> [Int] {

    let rootPosition = noteToValue(note: root)

    var currentPosition = rootPosition
    var positions: [Int] = []

    for note in notes {
        var notePostion = noteToValue(note: note)
        if notePostion < currentPosition {
            notePostion += 12 * ((currentPosition - notePostion) / 12 + 1)
        }
        positions.append(notePostion - rootPosition)
        currentPosition = notePostion
    }
    // print(positions)
    return positions
}
