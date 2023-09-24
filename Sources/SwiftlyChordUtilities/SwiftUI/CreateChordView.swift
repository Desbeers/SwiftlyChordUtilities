//
//  CreateChordView.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//
import SwiftUI

/**
 A SwiftUI `View` to create a ``ChordDefinition`` with pickers

 To use this `View`, the `ChordDisplayOptions` class must be added to your application as an `EnvironmentObject`
 */
public struct CreateChordView: View {
    public init() {}
    /// Chord Display Options object
    @EnvironmentObject var options: ChordDisplayOptions
    /// The chord diagram
    @State private var diagram: ChordDefinition?
    /// The current color scheme
    @Environment(\.colorScheme) private var colorScheme
    /// The chord finder result
    @State private var chordFinder: [ChordDefinition] = []
    /// The body of the `View`
    public var body: some View {
        VStack {
            Text("\(options.definition.root.rawValue) \(options.definition.quality.rawValue)")
                .font(.largeTitle)
            options.rootPicker
                .pickerStyle(.segmented)
                .padding(.bottom)
                .labelsHidden()
            HStack {
                LabeledContent(content: {
                    options.qualityPicker
                        .labelsHidden()
                }, label: {
                    Text("Quality:")
                })
                .frame(maxWidth: 150)
                LabeledContent(content: {
                    Picker("Base fret:", selection: $options.definition.baseFret) {
                        ForEach(1...20, id: \.self) { value in
                            Text(value.description)
                                .tag(value)
                        }
                    }
                    .labelsHidden()
                }, label: {
                    Text("Base fret:")
                })
                .frame(maxWidth: 150)
                LabeledContent(content: {
                    options.bassPicker
                        .labelsHidden()
                }, label: {
                    Text("Optional bass:")
                })
                .frame(maxWidth: 200)
            }
            HStack {
                VStack {
                    diagramView(width: 240)
                    chordFinderList
                }
                .frame(width: 300, height: 450)
                VStack {
                    Section(
                        content: {
                            options.fretsPicker
                        }, header: {
                            header(text: "Frets")
                        })
                    Section(
                        content: {
                            options.fingersPicker
                        }, header: {
                            header(text: "Fingers")
                        })
                }
#if os(macOS)
                .pickerStyle(.radioGroup)
#else
                .pickerStyle(.wheel)
#endif
                .frame(width: 400)
            }
            .frame(height: 440)
        }
        .task(id: options.definition) {
            let diagram = ChordDefinition(
                id: options.definition.id,
                name: options.definition.name,
                frets: options.definition.frets,
                fingers: options.definition.fingers,
                baseFret: options.definition.baseFret,
                root: options.definition.root,
                quality: options.definition.quality,
                bass: options.definition.bass,
                instrument: options.definition.instrument,
                status: .standard
            )
            self.diagram = diagram
            chordFinder = diagram.chordFinder
        }
    }

    @ViewBuilder var chordFinderList: some View {
        if let diagram {
            HStack {
                Text(diagram.chordFinder.isEmpty ? "Found nothing" : "Found")
                ForEach(diagram.chordFinder) { result in
                    Text(result.displayName(options: .init(rootDisplay: .symbol, qualityDisplay: .symbolized)))
                        .foregroundColor(
                            options.definition.root == result.root && options.definition.quality == result.quality ? .accentColor : .primary
                        )
                }
            }
        }
    }

    @ViewBuilder func diagramView(width: Double) -> some View {
        if let diagram {
            ChordDefinitionView(chord: diagram, width: width, options: options.displayOptions)
                .foregroundStyle(.primary, colorScheme == .light ? .white : .black)
        } else {
            ProgressView()
        }
    }

    func bassNote() -> Chord.Root? {

        let firstNote = diagram?.components.first(where: {$0.note != .none})?.note

        if let firstNote {
            return firstNote == options.definition.root ? nil : firstNote
        }
        return nil
    }

    func header(text: String) -> some View {
        VStack {
            Text(text)
                .font(.title2)
                .padding(.top)
            Divider()
        }
    }
}

