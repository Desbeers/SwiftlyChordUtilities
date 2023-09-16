//
//  Quality.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/// The structure for a chord quality
struct Quality {
    /// Name of quality
    var name: Chord.Quality
    /// Components of quality
    public var components: [Int]
    /// Init the quality
    init(quality: Chord.Quality, components: [Int]) {
        self.name = quality
        self.components = components
    }

    /// Get components of chord quality
    /// - Parameters:
    ///   - root: The root note of the chord
    /// - Returns: Components of chord quality
    func getComponents(root: Chord.Root) -> [Chord.Root] {
        let intComponents = getIntComponents(root: root)
        var components: [Chord.Root] = []
        for component in intComponents {
            components.append(valueToNote(value: component, scale: root))
        }
        return components
    }

    private func getIntComponents(root: Chord.Root) -> [Int] {
        let rootValue = noteToValue(note: root)
        var components: [Int] = []
        for component in self.components {
            components.append(component + rootValue)
        }
        return components
    }

    /// Append on chord
    /// - Parameters:
    ///   - onChord: Bass note of the chord
    ///   - root: Root note of the chord
    mutating func appendOnChord(_ onChord: Chord.Root, _ root: Chord.Root) {
        /// Get the value of the root note
        let rootValue = noteToValue(note: root)
        /// Get the value of the 'on' note
        var onChordValue = noteToValue(note: onChord) - rootValue
        /// Start with the current components
        var components = self.components
        /// Remove the 'on' note from the components, if it is included
        for (index, value) in self.components.enumerated() where (value % 12) == (onChordValue + 12) {
            components.remove(at: index)
            break
        }
        if onChordValue > rootValue {
            onChordValue -= 12
        }
        if !components.contains(onChordValue) {
            var componentsWithOnChord = [onChordValue]
            for component in components where (component % 12) != (onChordValue % 12) {
                componentsWithOnChord.append(component)
            }
            components = componentsWithOnChord
        }
        /// Update the components with the new values
        self.components = components
    }
}

/// Get the quality of a chord
/// - Parameters:
///   - name: The name of the quality
///   - inversion: The inversion
/// - Returns: A ``ChordUtilities/Quality``
func getQualityFromChord(name: Chord.Quality, inversion: Int) -> Quality {
    guard var quality = qualities.first(where: { $0.key == name }) else {
        return Quality(quality: name, components: [])
    }
    /// Apply the requested inversion
    for _ in 0..<inversion {
        var component = quality.value[0]
        while component < quality.value.count - 1 {
            component += 12
        }
        quality.value.append(component)
    }
    return Quality(quality: name, components: quality.value)
}

/// Find qualities from chord components
/// - Parameter components: Components of quality
/// - Returns: The `qualities`, if found
func findQualitiesFromComponents(components: [Int]) -> [Quality]? {
    var result: [Quality] = []
    for quality in qualities where quality.value == components {
        result.append(Quality(quality: quality.key, components: quality.value))
    }
    return result.isEmpty ? nil : result
}
