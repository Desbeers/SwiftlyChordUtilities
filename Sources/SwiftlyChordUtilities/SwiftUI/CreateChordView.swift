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
    /// The chord components result
    @State private var chordComponents: [[Chord.Root]] = []

    @State private var validate: Bool = false
    /// The body of the `View`
    public var body: some View {
        VStack {
            Text("\(options.definition.displayName(options: .init(rootDisplay: .raw, qualityDisplay: .raw)))")
                .font(.largeTitle)
            HStack {
                ForEach(options.definition.quality.intervals.intervals, id: \.self) { interval in
                    Text(interval.description)
                }
            }
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
                    Label(
                        title: {
                            if let components = chordComponents.first {
                                HStack {
                                    Text("**\(options.definition.displayName(options: .init()))** contains")
                                    ForEach(components, id: \.self) { element in
                                        Text(element.display.symbol)
                                            .fontWeight(checkRequiredNote(note: element) ? .bold : .regular)
                                    }
                                }
                            }
                        },
                        icon: { Image(systemName: "info.circle.fill") }
                    )
                    .padding(.bottom)
                    Text(diagram?.validate.label ?? "Unknown status")
                        .foregroundStyle(diagram?.validate.color ?? .primary)
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
            chordComponents = getChordComponents(chord: diagram)
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
    
    /// Check if a note is required for a chord
    ///
    /// The first array of the `chordComponents` contains all notes
    ///
    /// The last array of the `chordComponents` contains the least notes
    ///
    /// - Parameter note: The note to check
    /// - Returns: True or False
    func checkRequiredNote(note: Chord.Root) -> Bool {
        if let first = chordComponents.first, let last = chordComponents.last {
            let omitted = first.filter { !last.contains($0) }
            return omitted.contains(note) ? false : true
        }
        return true
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
