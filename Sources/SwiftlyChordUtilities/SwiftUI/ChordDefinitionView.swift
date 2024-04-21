//
//  ChordDefinitionView.swift
//  SwiftlyChordUtilities
//
//  © 2023 Nick Berendsen
//

import SwiftUI

/**
A SwiftUI `View` for a ``ChordDefinition``

 The `View` can be styled with the passed `DisplayOptions` and further with the usual SwiftUI modifiers.

**The color of the diagram are styled with the `.foregroundStyle` modifier**
- The color of the diagram is the primary color.
- The labels are the secondary color

 - Note: If you don't attacht a .foregroundStyle modifier, the labels are hard to see because the primary and secondary color are not that different.

**The height of the `View` is just as needed**

It will caclulate all the bits and pieces based on the *width* and will be not a fixed height. As always, you can set the *height* with a modifier as it pleases you.

 Best is to wrap the `View` in another `View` to attach any modifiers:
 ```swift
 /// SwiftUI `View` for a chord diagram
 struct ChordDiagramView: View {
     /// The chord
     let chord: ChordDefinition
     /// Width of the chord diagram
     var width: Double
     /// Display options
     var options: ChordDefinition.DisplayOptions
     /// The current color scheme
     @Environment(\.colorScheme) var colorScheme
     /// The body of the `View`
     var body: some View {
         ChordDefinitionView(chord: chord, width: width, options: options)
             .foregroundStyle(.primary, colorScheme == .dark ? .black : .white)
     }
 }
 ```
 If you want to render the chord for print; just set the style to 'black and white' and use `ImageRenderer` to get your image.
 */
public struct ChordDefinitionView: View {
    public init(chord: ChordDefinition, width: Double, options: ChordDefinition.DisplayOptions) {
        self.chord = chord
        self.options = options
        self.width = width
        self.lineHeight = width / 8
        /// This looks nice to me
        self.gridHeight = width * 0.9
        /// Calculate the cell width
        self.cellWidth = width / Double(chord.instrument.strings.count + 1)
        /// Calculate the horizontal padding
        self.horizontalPadding = cellWidth / 2
    }
    
    let chord: ChordDefinition
    let options: ChordDefinition.DisplayOptions
    let width: Double
    let gridHeight: Double
    let lineHeight: Double
    let cellWidth: Double
    let horizontalPadding: Double

    // MARK: Body of the View

    public var body: some View {
        VStack(spacing: 0) {
            if options.showName {
                Text(chord.displayName(options: options))
                    .font(.system(size: lineHeight, weight: .semibold, design: .default))
                    .padding(lineHeight / 4)
            }
            switch chord.status {
            case .standard, .transposed, .custom:
                diagram
            case .customTransposed:
                Text("A custom chord can not be transposed in the diagram")
                    .multilineTextAlignment(.center)
            case .unknown:
                Text("The chord is unknown")
                    .multilineTextAlignment(.center)
            }
        }
        /// Make the whole diagram clickable if needed
        .contentShape(Rectangle())
        .frame(width: width)
    }

    // MARK: String Grid

    var grid: some View {
        GridShape(instrument: chord.instrument)
            .stroke(.primary, style: StrokeStyle(lineWidth: 0.4, lineCap: .round, lineJoin: .round))
            .padding(.horizontal, cellWidth)
            //.frame(height: gridHeight)
    }

    // MARK: Diagram

    @ViewBuilder var diagram: some View  {
        if chord.frets.contains(-1) || chord.frets.contains(0) {
            topBar
        }
        if chord.baseFret == 1 {
            Rectangle()
                .padding(.horizontal, cellWidth / 1.2)
                .frame(height: width / 25)
                .offset(x: 0, y: 1)
        }
        ZStack(alignment: .topLeading) {
            grid
            if chord.baseFret != 1 {
                Text("\(chord.baseFret)")
                    .font(.system(size: lineHeight * 0.6, weight: .regular, design: .default))
                    .frame(height: gridHeight / 5)
            }
            if !chord.barres.isEmpty {
                barGrid
            }
            fretGrid
        }
        .frame(height: gridHeight)
        if options.showNotes {
            notesBar
        }
        if options.showPlayButton {
            ChordDisplayOptions.PlayButton(chord: chord, instrument: options.midiInstrument)
                .font(.body)
                .padding(.top, options.showNotes ? 0 : lineHeight / 2)
                .padding(.bottom, lineHeight / 2)
        }
    }

    // MARK: Top Bar

    var topBar: some View {
        HStack(spacing: 0) {
            ForEach(chord.frets.indices, id: \.self) { index in
                let fret = chord.frets[index]
                VStack {
                    switch fret {
                    case -1:
                        Image(systemName: "xmark")
                            .symbolRenderingMode(.palette)
                    case 0:
                        Image(systemName: "circle")
                            .symbolRenderingMode(.palette)
                    default:
                        Color.clear
                    }
                }
                .font(.system(size: lineHeight * 0.6, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity)
                .frame(height: lineHeight)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x:0, y:1, z:0))
    }

    // MARK: Fret Grid

    var fretGrid: some View {
        let frets = options.mirrorDiagram ? chord.frets.reversed() : chord.frets
        let fingers = options.mirrorDiagram ? chord.fingers.reversed() : chord.fingers
        return Grid(alignment: .top, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach((1...5), id: \.self) { row in
                GridRow {
                    ForEach(chord.instrument.strings, id: \.self) { column in
                        if frets[column] == row && !chord.barres.contains(fingers[column]) {
                            VStack(spacing: 0) {
                                switch options.showFingers {
                                case true:
                                    Image(systemName: "\(fingers[column]).circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.secondary, .primary)
                                case false:
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .symbolRenderingMode(.palette)
                                }
                            }
                            .frame(height: lineHeight)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Color.clear
                        }
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }

    // MARK: Bar Grid

    var barGrid: some View {
        VStack(spacing: 0) {
            ForEach((1...5), id: \.self) { row in
                checkBar(barre: row)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .frame(width: width, height: gridHeight)
    }

    private func checkBar(barre: Int) -> some View {
        var isBarre: Bool = false
        var finger: Int = 0
        for column in chord.frets.indices {
            if chord.frets[column] == barre && chord.barres.contains(chord.fingers[column]) {
                isBarre = true
                finger = chord.fingers[column]
            }
        }
        return Group {
            switch isBarre {
            case true:
                calculateBar(barre: barre, finger: finger)
            case false:
                Color.clear
            }
        }
    }

    private func calculateBar(barre: Int, finger: Int) -> some View {
        /// Draw barre behind all frets that are above the barre chord
        var startIndex = (chord.frets.firstIndex { $0 == barre } ?? 0)
        let barreFretCount = chord.frets.filter { $0 == barre }.count
        var length = 0

        for index in startIndex..<chord.frets.count {
            let dot = chord.frets[index]
            if dot >= barre {
                length += 1
            } else if dot < barre && length < barreFretCount {
                length = 0
                startIndex = index + 1
            } else {
                break
            }
        }

        let endIndex = startIndex + length

        return HStack(spacing: 0) {
            if startIndex != 0 {
                Color.clear
                    .frame(width: cellWidth * Double(startIndex))
            }
            ZStack {
                RoundedRectangle(cornerSize: .init(width: lineHeight, height: lineHeight))
                    .frame(height: lineHeight)
                    .frame(width: cellWidth * Double(length))
                if options.showFingers {
                    Image(systemName: "\(finger).circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.secondary, .clear)
                        .frame(height: lineHeight)
                        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x:0, y:1, z:0))
                }
            }
            if endIndex < chord.instrument.strings.count {
                Color.clear
                    .frame(width: cellWidth * Double(chord.instrument.strings.count - endIndex))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x:0, y:1, z:0))
    }

    // MARK: Notes Bar


    /// Show the notes of the chord
    var notesBar: some View {
        let notes = options.mirrorDiagram ? chord.components.reversed() : chord.components
        return HStack(spacing: 0) {
            ForEach(notes) { note in
                VStack {
                    switch note.note {
                    case .none:
                        Color.clear
                    default:
                        Text("\(note.note.display.symbol)")
                    }
                }
                .font(.system(size: lineHeight * 0.6, weight: .regular, design: .default))
                .frame(maxWidth: .infinity)
                .frame(height: lineHeight * 0.8)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, lineHeight / 2)
    }
}

// MARK: GridShape

extension ChordDefinitionView {
    
    struct GridShape: Shape {

        let instrument: Instrument

        func path(in rect: CGRect) -> Path {
            let columns = instrument.strings.count - 1
            let width = rect.width
            let height = rect.height
            let xSpacing = width / Double(columns)
            let ySpacing = height / 5

            var path = Path()

            //for index in 0...instrument.strings.count - 1 {
            for index in 0...columns {
                let vOffset: CGFloat = CGFloat(index) * xSpacing
                path.move(to: CGPoint(x: vOffset, y: 0))
                path.addLine(to: CGPoint(x: vOffset, y: height))
            }
            for index in 0...5 {
                let hOffset: CGFloat = CGFloat(index) * ySpacing
                path.move(to: CGPoint(x: 0, y: hOffset))
                path.addLine(to: CGPoint(x: width, y: hOffset))
            }

            return path
        }
    }

}
