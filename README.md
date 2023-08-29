# ``SwiftlyChordUtilities``

A Swift package to handle musical chords.

## Overview

This package extents [Swifty Guitar Chords](https://github.com/BeauNouvelle/SwiftyGuitarChords) with some additional chord handling.

It is very much a *not complete* 'Swift Port' of [PyChord](https://github.com/yuma-m/pychord)

## General functions

    getChordInfo: Get info about a 'SwiftyChords' chord
    
    findRootAndQuality: Parse a chord String and get 'SwiftyChords' enum details
    
    define: Create a 'SwityChords' chord from a ChorpPro 'define' directive

## SwiftyChords extensions

### ChordPosition

    var notes: Get the notes of a chord based on its MIDI values
    
    var chordFinder: Find matching chords based on the notes. It will not find all chords!
    
    var define: Convert the chord into a ChordPro 'define' string
    
    func play: Play the chord with MIDI
    
## SwiftUI bits and pieces

### MIDI player

- A 'play chord' button
- An 'instrument' picker

## In use

I use this package in my following projects:

- [Chord Provider](https://github.com/Desbeers/Chord-Provider)
- [Chords Database](https://github.com/Desbeers/Chords-Database); mainly written to check the 'SwiftyChords' database and make PR's for it

## Documentation

This package is pretty well documented with DocC.

In Xcode: `Product->Build Documentation`.

