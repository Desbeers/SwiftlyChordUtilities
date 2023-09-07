//
//  Qualities.swift
//  SwiftlyChordUtilities
//
//  © 2022 Nick Berendsen
//

import Foundation

/*

 0:  R:     Perfect Unison
 1:  m2:    Minor Second
 2:  M2:    Major Second
 3:  m3:    Augmented Second / Minor Third
 4:  M3:    Major Third
 5:  P4:    Perfect Fourth
 6:  A4/d5: Augmented Fourth / Diminished Fifth
 7:  P5:    Perfect Fifth
 8:  A5/m6: Augmented Fifth / Minor Sixth
 9:  M6:    Major Sixth
 10: m7:    Minor Seventh
 11: M7:    Major Seventh

 */

var qualities: KeyValuePairs<Chords.Quality, [Int]> {
    [
        /*
         Notes: C E G
         Interval structure: R M3 P5
         */
        /// # 'major' chords
        .major: [0, 4, 7],

        /*
         Notes: C Eb G
         Interval structure: R m3 P5
         */
        /// # 'minor' chords
            .minor: [0, 3, 7],

        /*
         Notes: C Eb Gb
         Interval structure: R m3 d5
         */
        /// # 'dim' chords
            .dim: [0, 3, 6],

        /*
         Notes: C Eb Gb A
         Interval structure: R m3 d5 M6
         */
        /// # 'dim7' chords
            .dimSeven: [0, 3, 6, 9],

        /*
         Notes: C D G
         Interval structure: R M2 P5
         */
        /// # 'sus2' chords
            .susTwo: [0, 2, 7],

        /*
         Notes: C F G
         Interval structure: R P4 P5
         */
        /// # 'sus4' chords
            .susFour: [0, 5, 7],

        /*
         Notes: C G A# F
         Interval structure: R P4 P5 m7
         */
        /// # '7sus4' chords
            .sevenSusFour: [0, 5, 7, 10],

        /*
         Notes: C E Ab
         Interval structure: R M3 m6
         */
        /// # 'aug' chords
            .aug: [0, 4, 8],

        /*
         Notes: C G
         Interval structure: R M5
         */
        /// # '5' chords
            .five: [0, 7],

        /*
         Notes: C E G A
         Interval structure: R M3 M5 M6
         */
        /// # '6' chords
            .six: [0, 4, 7, 9],
        /// - Note: The 5th can be omitted
        .six: [0, 4, 9],

        /*
         Notes: C E G A D
         Interval structure: R M2 M3 P5 M6
         */
        /// # '6/9' chords
            .sixNine: [0, 2, 4, 7, 9],
        /// - Note: The 5th can be omitted
        .sixNine: [0, 2, 4, 9],

        /*
         Notes: C E G Bb
         Interval structure: R M3 P5 m7
         */
        /// # '7' chords
            .seven: [0, 4, 7, 10],
        /// - Note: The 5th can be omitted
        .seven: [0, 4, 10],

        /*
         Notes: C E Gb Bb
         Interval structure: R M3 d5 m7
         */
        /// # '7b5' chords
            .sevenFlatFive: [0, 4, 6, 10],

        /*
         Notes: C E Gb Bb
         Interval structure: R M3 d5 m7
         */
        /// # '7#5' chords
            .sevenSharpFive: [0, 4, 8, 10],

        /*
         Notes: C E G# Bb
         Interval structure: R M3 m6 m7
         */
        /// # 'aug7' chords
            .augSeven: [0, 4, 8, 10],

        /*
         Notes: C E Bb Db G
         Interval structure: R m2 M3 P5 m7
         */
        /// # '7b9' chords
            .sevenFlatNine: [0, 1, 4, 7, 10],
        /// - Note: The 5th can be omitted
        .sevenFlatNine: [0, 1, 4, 10],

        /*
         Notes: C Eb E G Bb
         Interval structure: R m3 M3 P5 M7
         */
        /// # '7#9' chords
            .sevenSharpNine: [0, 3, 4, 7, 10],
        /// - Note: The 5th can be omitted
        .sevenSharpNine: [0, 3, 4, 10],

        /*
         Notes: C E G Bb D
         Interval structure: R M2 M3 P5 m7
         */
        /// # '9' chords
            .nine: [0, 2, 4, 7, 10],
        /// - Note: The 5th can be omitted
        .nine: [0, 2, 4, 10],

        /*
         Notes: C E Gb Bb D
         Interval structure: R M2 M3 d5 m7
         */
        /// # '9b5' chords
            .nineFlatFive: [0, 2, 4, 6, 10],

        /*
         Notes: C D E Gb G Bb
         Interval structure: R  M2 M3 d5 P5 m7
         */
        /// # '9#11' chords
            .nineSharpEleven: [0, 2, 4, 6, 7, 10],
        /// - Note: The 5th can be omitted
        .nineSharpEleven: [0, 2, 4, 6, 10],

        /*
         Notes: C E G Bb D F
         Interval structure: R m2 M3 P4 P5 m7
         */
        /// # '11' chords
            .eleven: [0, 2, 4, 5, 7, 10],
        /// - Note: The 2nd can be omitted
        .eleven: [0, 4, 5, 7, 10],
        /// - Note: Both the 2nd and 5th can be omitted
        .eleven: [0, 4, 5, 10],

        /*
         Notes: C E G Bb A
         Interval structure: R M3 P5 M6 m7
         */
        /// # '13' chords
            .thirteen: [0, 4, 7, 9, 10],
        /// - Note: The 5th can be omitted
        .thirteen: [0, 4, 9, 10],

        /*
         Notes: C E G B
         Interval structure: R M3 P5 M7
         */
        /// # 'Maj7' chords
            .majorSeven: [0, 4, 7, 11],

        /*
         Notes: C E Gb B
         Interval structure: R M3  d5 M7
         */
        /// # 'Maj7b5' chords
            .majorSevenFlatFive: [0, 4, 6, 11],

        /*
         Notes: C E Ab E
         Interval structure: R M3 m6 M7
         */
        /// # 'Maj7#5' chords
            .majorSevenSharpFive: [0, 4, 8, 11],

        /*
         Notes: C E G D B
         Interval structure: R M2 M3 P5, M7
         */
        /// # 'Maj9' chords
            .majorNine: [0, 2, 4, 7, 11],
        /// - Note: The 5th can be omitted
        .majorNine: [0, 2, 4, 11],

        /*
         Notes: C E G B F
         Interval structure: R M3 P4 P5 M7
         */
        /// # 'Maj11' chords
            .majorEleven: [0, 4, 5, 7, 11],
        /// - Note: The 5th can be omitted
        .majorEleven: [0, 4, 5, 11],

        /*
         Notes: C E G B A
         Interval structure: R M3 P5 M6 M7
         */
        /// # 'Maj13' chords
            .majorThirteen: [0, 4, 7, 9, 11],
        /// - Note: The 5th can be omitted
        .majorThirteen: [0, 4, 9, 11],

        /*
         Notes: C Eb G A
         Interval structure: R m3 P5 M6
         */
        /// # 'minor6' chords
            .minorSix: [0, 3, 7, 9],

        /*
         Notes: C D D# G A
         Interval structure: R M2 m3 P5 M6
         */
        /// # 'minor6/9' chords
            .minorSixNine: [0, 2, 3, 7, 9],
        /// - Note: The 5th can be omitted
        .minorSixNine: [0, 2, 3, 9],

        /*
         Notes: C Eb G Bb
         Interval structure: R m3 P5 m7
         */
        /// # 'minor7' chords
            .minorSeven: [0, 3, 7, 10],
        /// - Note: The 5th can be omitted
        .minorSeven: [0, 3, 10],

        /*
         Notes: C Eb Gb Bb
         Interval structure: R m3 d5 m7
         */
        /// # 'minor7b5' chords
            .minorSevenFlatFive: [0, 3, 6, 10],

        /*
         Notes: C Eb G Bb D
         Interval structure: R M2 m3 P5 m7
         */
        /// # 'minor9' chords
            .minorNine: [0, 2, 3, 7, 10],

        /*
         Notes: C Eb G Bb F
         Interval structure: R m3 P4 P5 m7
         */
        /// # 'minor11' chords
            .minorEleven: [0, 3, 5, 7, 10],
        /// - Note: The 5th can be omitted
        .minorEleven: [0, 3, 5, 10],

        /*
         Notes: C Eb G B
         Interval structure: R m3 P5 M7
         */
        /// # 'minorMajor7' chord
            .minorMajorSeven: [0, 3, 7, 11],

        /*
         Notes: C Eb Gb B
         Interval structure: R m3 d5 M7
         */
        /// # 'minorMajor7b5' chord
            .minorMajorSeventFlatFive: [0, 3, 6, 11],

        /*
         Notes: C Eb G B D
         Interval structure:
         */
        /// # 'minorMajor9' chord
            .minorMajorNine: [0, 2, 3, 7, 11],

        /*
         Notes: C Eb G B F
         Interval structure: R m3 P4 P5 M7
         */
        /// # 'minorMajor11' chord
            .minorMajorEleven: [0, 3, 5, 7, 11],
        /// - Note: The 5th can be omitted
        .minorMajorEleven: [0, 3, 5, 11],

        /*
         Notes: C E G D
         Interval structure: R M2 M3 P5
         */
        /// # 'add9' chord
            .addNine: [0, 2, 4, 7],

        /*
         Notes: C Eb G D
         Interval structure: R M2 m3 P5
         */
        /// #'minorAdd9' chord
            .minorAddNine: [0, 2, 3, 7]
    ]
}
