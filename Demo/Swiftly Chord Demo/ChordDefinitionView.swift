//
//  ChordDefinitionView.swift
//  ChordTest
//
//  Created by Nick Berendsen on 09/09/2023.
//

import SwiftUI
import SwiftlyChordUtilities

public struct ChordDefinitionView: View {
    public init(chord: ChordDefinition, size: Double, options: ChordDefinition.DisplayOptions) {
        self.chord = chord
        self.options = options
        self.size = size
        self.fontSize = size / 10
        self.frets = options.mirrorDiagram ? chord.frets.reversed() : chord.frets
        self.fingers = options.mirrorDiagram ? chord.fingers.reversed() : chord.fingers
        self.padding = size / 14
    }

    let chord: ChordDefinition
    let options: ChordDefinition.DisplayOptions
    let size: Double

    let fontSize: Double

    let padding: Double

    let frets: [Int]
    let fingers: [Int]

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            if options.showName {
                Text("\(chord.displayName(options: options))")
                    .font(.system(size: fontSize, weight: .semibold, design: .default))
                    .padding(fontSize / 2)
            }
            if chord.frets.contains(-1) || chord.frets.contains(0) {
                topGrid
            }
            if chord.baseFret == 1 {
                Rectangle()
                    .foregroundStyle(.primary)
                    .padding(.horizontal, padding * 1.2)
                    .frame(height: size / 25)
            }
            ZStack(alignment: .topLeading) {
                GridShape(rows: 5.0, cols: 5.0, gridColor: .primary)
                    .strokeBorder(.primary, lineWidth: 1)
                    .offset(x: 0, y: -1)
                    .padding(.horizontal, padding * 1.5)

                if chord.baseFret != 1 {
                    Text("\(chord.baseFret)")
                        .font(.system(size: fontSize * 0.6, weight: .regular, design: .default))
                }
                if !chord.barres.isEmpty {
                    barGrid
                }
                fretGrid

            }
        }
        .frame(width: size)
        .drawingGroup()
        .background(Color.red.opacity(0.2))
    }

    var topGrid: some View {
        HStack(spacing: 0) {
            ForEach(0...5, id: \.self) { index in

                let fret = chord.frets[index]

                VStack {
                    switch fret {
                    case -1:
                        Image(systemName: "xmark")
                    case 0:
                        Image(systemName: "circle")

                    default:
                        Color.clear
                    }
                }
                .font(.system(size: fontSize * 0.8, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity)
                .frame(height: fontSize)
            }
        }
        .padding(.horizontal, padding / 2)
        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
    }

    var fretGrid: some View {
        Grid(alignment: .top, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach((1...5), id: \.self) { row in
                GridRow {
                    ForEach((0...5), id: \.self) { column in
                        if frets[column] == row && !chord.barres.contains(row) {
                            VStack(spacing: 0) {
                                switch options.showFingers {
                                case true:
                                    Image(systemName: "\(fingers[column]).circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(colorScheme == .dark ? .black : .white, .primary)
                                case false:
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                            .frame(height: fontSize)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Color.clear
                        }
                    }
                }
            }
        }
        .padding(.horizontal, padding / 2)
        .frame(width: size, height: (size - (padding * 3)))
    }

    var barGrid: some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach((1...5), id: \.self) { row in
                if chord.barres.contains(row) {
                    calculateBar(barre: row)
                } else {
                    Color.clear
                        .gridCellColumns(6)
                }
            }
        }
        .padding(.horizontal, padding)
        .frame(width: size, height: (size - (padding * 3)))
    }

    private func calculateBar(barre: Int) -> some View {

        let celWidth = (size - padding) / 6.5

        // draw barre behind all frets that are above the barre chord
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
        return HStack(spacing: 0) {
            if startIndex != 0 {
                Color.clear
                    .frame(width: celWidth * Double(startIndex))
            }
            ZStack {
                RoundedRectangle(cornerSize: .init(width: fontSize, height: fontSize))
                    .frame(height: fontSize)
                    .frame(width: celWidth * Double(length))
                if options.showFingers {
                    Image(systemName: "\(barre).circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(colorScheme == .dark ? .black : .white, .primary)
                        .frame(height: fontSize)
                        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotation3DEffect(options.mirrorDiagram ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
    }
}

// MARK: GridShape

extension ChordDefinitionView {

    struct GridShape: InsettableShape {

        let rows: CGFloat
        let cols: CGFloat
        let gridColor: Color

        var insetAmount = 0.0

        func inset(by amount: CGFloat) -> some InsettableShape {
            var grid = self
            grid.insetAmount += amount
            return grid
        }

        func path(in rect: CGRect) -> Path {

            let width = geometry.size.width
            let height = geometry.size.height
            let xSpacing = width / cols
            let ySpacing = height / rows

            var path = Path()

            for index in 0...Int(cols) {
                let vOffset: CGFloat = CGFloat(index) * xSpacing
                path.move(to: CGPoint(x: vOffset, y: 0))
                path.addLine(to: CGPoint(x: vOffset, y: height))
            }
            for index in 0...Int(rows) {
                let hOffset: CGFloat = CGFloat(index) * ySpacing
                path.move(to: CGPoint(x: 0, y: hOffset))
                path.addLine(to: CGPoint(x: width, y: hOffset))
            }

//            let width = rect.width
//            let spacing = width / cols
//            let height = spacing * rows
//
//            var path = Path()
//
//            for index in 0...Int(cols) {
//                let vOffset: CGFloat = CGFloat(index) * spacing
//                path.move(to: CGPoint(x: vOffset, y: 0))
//                path.addLine(to: CGPoint(x: vOffset, y: height))
//            }
//            for index in 0...Int(rows) {
//                let hOffset: CGFloat = CGFloat(index) * spacing
//                path.move(to: CGPoint(x: 0, y: hOffset))
//                path.addLine(to: CGPoint(x: width, y: hOffset))
//            }
            return path
        }
    }

}
