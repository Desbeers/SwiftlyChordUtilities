//
//  MidiPlayer.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//
//  Thanks: https://readdarek.com/how-to-play-midi-in-swift/

import SwiftUI
import AVFoundation

/// Play a ’SwiftyChords` chord with its MIDI values
public class MidiPlayer {
    /// Make it a shared class
    static let shared = MidiPlayer()
    /// The MIDI player
    var midiPlayer: AVMIDIPlayer?
    /// The URL of the SoundBank
    /// - Note: A stripped version of the `GeneralUser GS MuseScore` bank
    var bankURL: URL
    /// Private init to make sure the class is shared
    private init() {
        /// Get the Sound Font
        guard let bankURL = Bundle.module.url(forResource: "GuitarSoundFont", withExtension: "sf2") else {
            fatalError("SoundFont not found.")
        }
        self.bankURL = bankURL
    }

    /// Prepair a chord
    /// - Parameter chord: The ``chord`` to play
    func prepareChord(chord: Chord){
        /// Black magic
        var data: Unmanaged<CFData>?
        guard MusicSequenceFileCreateData(
            chord.musicSequence!,
            MusicSequenceFileTypeID.midiType,
            MusicSequenceFileFlags.eraseFile,
            480, &data) == OSStatus(noErr
            ) else {
            fatalError("Cannot create music midi data")
        }
        if let data {
            let midiData = data.takeUnretainedValue() as Data
            do {
                try midiPlayer = AVMIDIPlayer(data: midiData, soundBankURL: bankURL)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
        self.midiPlayer!.prepareToPlay()
    }

    /// Play a chord with its MIDI values
    /// - Parameters:
    ///   - notes: The notes to play
    ///   - instument: The ``Instrument`` to use
    func playChord(notes: [Int], instrument: Instrument = .acousticNylonGuitar) async {
        let composer = Chord()
        let chord = composer.compose(notes: notes, instrument: instrument)
        prepareChord(chord: chord)
        if let midiPlayer {
            midiPlayer.currentPosition = 0
            await midiPlayer.play()
        }
    }
}

extension MidiPlayer {

    /// SwiftUI Button to play the chord with MIDI
    public struct PlayButton: View {
        /// Public init
        public init(chord: ChordPosition) {
            self.chord = chord
        }
        /// The chord to play
        let chord: ChordPosition
        /// The selected MIDI instrument
        @AppStorage("MIDI instrument") private var instrument: MidiPlayer.Instrument = .acousticNylonGuitar
        /// The body of the View
        public var body: some View {
            Button(action: {
                chord.play(instrument: instrument)
            }, label: {
                Label("Play", systemImage: "play.fill")
            })
            .disabled(chord.midi.isEmpty)
        }
    }
}
