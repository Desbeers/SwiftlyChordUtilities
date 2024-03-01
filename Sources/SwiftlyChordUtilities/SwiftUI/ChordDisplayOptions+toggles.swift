//
//  ChordDisplayOptions+toggles.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//


import SwiftUI

extension ChordDisplayOptions{

    // MARK: Name Toggle

    /// SwiftUI `View` with a `Toggle` to show or hide the name on the diagram
    public var nameToggle: some View {
        NameToggle(chordDisplayOptions: self)
    }
    //// SwiftUI `View` with a `Toggle` to show or hide the name on the diagram
    struct NameToggle: View {
        /// Chord Display Options object
        @Bindable var chordDisplayOptions: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Toggle(isOn: $chordDisplayOptions.displayOptions.showName) {
                Label("Show name", systemImage:  chordDisplayOptions.displayOptions.showName ? "a.square.fill" : "a.square")
            }
        }
    }

    // MARK: Fingers Toggle

    /// SwiftUI `View` with a `Toggle` to show or hide the fingers on the diagram
    public var fingersToggle: some View {
        FingersToggle(chordDisplayOptions: self)
    }
    /// SwiftUI `View` with a `Toggle` to show or hide the fingers on the diagram
    struct FingersToggle: View {
        /// Chord Display Options object
        @Bindable var chordDisplayOptions: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Toggle(isOn: $chordDisplayOptions.displayOptions.showFingers) {
                Label("Show fingers", systemImage: chordDisplayOptions.displayOptions.showFingers ? "hand.raised.fingers.spread.fill" : "hand.raised.fingers.spread")
            }
        }
    }

    // MARK: Notes Toggle

    /// SwiftUI `View` with a `Toggle` to show or hide the notes on the diagram
    public var notesToggle: some View {
        NotesToggle(chordDisplayOptions: self)
    }
    /// SwiftUI `View` with a `Toggle` to show or hide the notes on the diagram
    struct NotesToggle: View {
        /// Chord Display Options object
        @Bindable var chordDisplayOptions: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Toggle(isOn: $chordDisplayOptions.displayOptions.showNotes) {
                Label("Show notes", systemImage:  chordDisplayOptions.displayOptions.showNotes ? "music.note.list" : "music.note")
            }
        }
    }

    // MARK: Mirror Toggle

    /// SwiftUI `View` with a `Toggle`  to mirror the diagram
    public var mirrorToggle: some View {
        MirrorToggle(chordDisplayOptions: self)
    }
    /// SwiftUI `View` with a `Toggle`  to mirror the diagram
    struct MirrorToggle: View {
        /// Chord Display Options object
        @Bindable var chordDisplayOptions: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Toggle(isOn: $chordDisplayOptions.displayOptions.mirrorDiagram) {
                Label("Mirror diagram", systemImage:  chordDisplayOptions.displayOptions.mirrorDiagram ? "hand.point.left.fill" : "hand.point.right.fill")
            }
        }
    }

    // MARK: Play Toggle

    /// SwiftUI `View` with a `Toggle` to show or hide the play button
    public var playToggle: some View {
        PlayToggle(chordDisplayOptions: self)
    }
    /// SwiftUI `View` with a `Toggle`  to show or hide the play button
    struct PlayToggle: View {
        /// Chord Display Options object
        @Bindable var chordDisplayOptions: ChordDisplayOptions
        /// The body of the `View`
        var body: some View {
            Toggle(isOn: $chordDisplayOptions.displayOptions.showPlayButton) {
                Label("Show play button", systemImage:  chordDisplayOptions.displayOptions.showPlayButton ? "play.fill" : "play")
            }
        }
    }
}
