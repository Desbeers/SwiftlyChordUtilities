//
//  File.swift
//  
//
//  Created by Nick Berendsen on 19/09/2023.
//

import Foundation

public extension Chord {
    
    /// A dictionary with optional names for a quality
    static var qualityNameDict: [Quality: [String]] {
        [
            .major: ["major", "maj"],
            .minor: ["minor", "min", "m"],
            .dim: ["dim"],
            .dimSeven: ["dim7"],
            .susTwo: ["sus2"],
            .susFour: ["sus4"],
            .sevenSusTwo: ["7sus2"],
            .sevenSusFour: ["7sus4"],
            .five: ["5"],
            .altered: ["alt"],
            .aug: ["aug", "+"],
            .six: ["6"],
            .sixNine: ["6/9", "69"],
            .seven: ["7"],
            .sevenFlatFive: ["7b5"],
            .augSeven: ["aug7"],
            .nine: ["9"],
            .minorNine: ["m9"],
            .nineFlatFive: ["9b5"],
            .augNine: ["aug9"],
            .sevenFlatNine: ["7b9"],
            .sevenSharpNine: ["7#9"],
            .eleven: ["11"],
            .nineSharpEleven: ["9#11"],
            .thirteen: ["13"],
            .minorThirteen: ["m13"],
            .majorSeven: ["maj7"],
            .majorSevenFlatFive: ["maj7b5"],
            .majorSevenSharpFive: ["maj7#5"],
            .sevenSharpFive: ["7#5"],
            .majorNine: ["maj9"],
            .majorEleven: ["maj11"],
            .majorThirteen: ["maj13"],
            .minorSix: ["m6"],
            .minorSixNine: ["m6/9", "m69"],
            .minorSeven: ["m7"],
            .minorSevenFlatFive: ["m7b5"],
            .minorEleven: ["m11"],
            .minorMajorSeven: ["mmaj7", "mMaj7"],
            .minorMajorSeventFlatFive: ["mmaj7b5", "mMaj7b5"],
            .minorMajorNine: ["mmaj9", "mMaj9"],
            .minorMajorEleven: ["mmaj11", "mMaj11"],
            .addNine: ["add9"],
            .minorAddNine: ["madd9"],
            .unknown: ["?"]
        ]
    }
}
