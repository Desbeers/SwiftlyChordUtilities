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
func findRootAndQuality(chord: String) -> (root: Chord.Root?, quality: Chord.Quality?, bass: Chord.Root?) {

    var root: Chord.Root?
    var quality: Chord.Quality?
    var bass: Chord.Root?
    if let match = chord.firstMatch(of: chordRegex) {
        root = match.1
        if let qualityMatch = match.2 {
            quality = qualityMatch
        } else {
            quality = Chord.Quality.major
        }
        bass = match.3
    }
    return (root, quality, bass)
}

/// Find possible chords consisted from notes
/// - Parameter notes: List of note arranged from lower note. ex ["C", "Eb", "G"]
/// - Returns: A ``ChordDefinition``array
func findChordsFromNotes(notes: [Chord.Root], instrumemt: Instrument) -> [ChordDefinition] {
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
                var bass: Chord.Root?
                if tempRoot != root {
                    bass = root
                }
                chords.append(
                    ChordDefinition(
                        id: UUID(),
                        name: "\(root.rawValue)\(quality.name.rawValue)",
                        frets: [],
                        fingers: [],
                        baseFret: 0,
                        root: tempRoot,
                        quality: quality.name,
                        bass: bass,
                        instrument: instrumemt,
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
    return positions
}
