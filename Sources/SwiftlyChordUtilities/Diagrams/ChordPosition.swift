//
//  File.swift
//  
//
//  Created by Beau Nouvelle on 2020-03-29.
//

import Foundation
import CoreGraphics

#if os(macOS)
import AppKit
#else
import UIKit
#endif

public struct ChordPosition: Codable, Identifiable, Equatable {
    
    public init(id: UUID = UUID(), frets: [Int], fingers: [Int], baseFret: Int, barres: [Int], capo: Bool? = nil, midi: [Int], key: Chords.Key, suffix: Chords.Suffix) {
        self.id = id
        self.frets = frets
        self.fingers = fingers
        self.baseFret = baseFret
        self.barres = barres
        self.capo = capo
        self.midi = midi
        self.key = key
        self.suffix = suffix
    }
    
    public var id: UUID = UUID()

    public let frets: [Int]
    public let fingers: [Int]
    public let baseFret: Int
    public let barres: [Int]
    public var capo: Bool?
    public let midi: [Int]
    public let key: Chords.Key
    public let suffix: Chords.Suffix
    
    static private let numberOfStrings = 6 - 1
    static private let numberOfFrets = 5

    private enum CodingKeys: String, CodingKey {
        case frets, fingers, baseFret, barres, capo, midi, key, suffix
    }

    /// This is THE place to pull out a CAShapeLayer that includes all parts of the chord chart. This is what to use when adding a layer to your UIView/NSView.
    /// - Parameters:
    ///   - rect: The area for which the chord will be drawn to. This determines it's size. Chords have a set aspect ratio, and so the size of the chord will be based on the shortest side of the rect.
    ///   - showFingers: Determines if the finger numbers should be drawn on top of the dots. Default `true`.
    ///   - chordName: Determines if the chord name should be drawn above the chord. Choosing this option will reduce the size of the chord chart slightly to account for the text. Default `true`. The display mode can be set for Key and Suffix. Default  `rawValue`
    ///   - forPrint: If set to `true` the diagram will be colored Black, not matter the users device settings. If set to false, the color of the diagram will match the system label color. Dark text for light mode, and Light text for dark mode. Default `false`.
    ///   - mirror: For lefthanded users. This will flip the chord along its y axis. Default `false`.
    /// - Returns: A CAShapeLayer that can be added as a sublayer to a view, or rendered to an image.
    public func chordLayer(rect: CGRect, showFingers: Bool = true, chordName: Chords.Name = Chords.Name(), forPrint: Bool = false, mirror: Bool = false) -> CAShapeLayer {
        return privateLayer(rect: rect, showFingers: showFingers, chordName: chordName, forScreen: !forPrint, mirror: mirror)
    }
    
    /// Now deprecated. Please see the chordLayer() function.
    /// - Parameters:
    ///   - rect: The area for which the chord will be drawn to. This determines it's size. Chords have a set aspect ratio, and so the size of the chord will be based on the shortest side of the rect.
    ///   - showFingers: Determines if the finger numbers should be drawn on top of the dots. Default `true`.
    ///   - showChordName: Determines if the chord name should be drawn above the chord. Choosing this option will reduce the size of the chord chart slightly to account for the text. Default `true`.
    ///   - forPrint: If set to `true` the diagram will be colored Black, not matter the users device settings. If set to false, the color of the diagram will match the system label color. Dark text for light mode, and Light text for dark mode. Default `false`.
    ///   - mirror: For lefthanded users. This will flip the chord along its y axis. Default `false`.
    /// - Returns: A CAShapeLayer that can be added as a sublayer to a view, or rendered to an image.
    @available(*, deprecated, message: "Chord name can be formatted now.", renamed: "chordLayer")
    public func shapeLayer(rect: CGRect, showFingers: Bool = true, showChordName: Bool = true, forPrint: Bool = false, mirror: Bool = false) -> CAShapeLayer {
        return privateLayer(rect: rect, showFingers: showFingers, chordName: Chords.Name(show: showChordName, key: .raw, suffix: .raw), forScreen: !forPrint, mirror: mirror)
    }

    /// Now deprecated. Please see the chordLayer() function.
    /// - Parameters:
    ///   - rect: The area for which the chord will be drawn to. This determines it's size. Chords have a set aspect ratio, and so the size of the chord will be based on the shortest side of the rect.
    ///   - showFingers: Determines if the finger numbers should be drawn on top of the dots.
    ///   - showChordName: Determines if the chord name should be drawn above the chord. Choosing this option will reduce the size of the chord chart slightly to account for the text.
    ///   - forScreen: This takes care of Dark/Light mode. If it's on device ONLY, set this to true. When adding to a PDF, you'll want to set this to false.
    ///   - mirror: For lefthanded users. This will flip the chord along its y axis.
    /// - Returns: A CAShapeLayer that can be added to a view, or rendered to an image.
    @available(*, deprecated, message: "For screen should have been defaulted to 'true'. Also; chord name can be formatted now.", renamed: "chordLayer")
    public func layer(rect: CGRect, showFingers: Bool, showChordName: Bool, forScreen: Bool, mirror: Bool = false) -> CAShapeLayer {
        return privateLayer(rect: rect, showFingers: showFingers, chordName: Chords.Name(show: showChordName, key: .raw, suffix: .raw), forScreen: forScreen, mirror: mirror)
    }

    private func privateLayer(rect: CGRect, showFingers: Bool, chordName: Chords.Name, forScreen: Bool, mirror: Bool = false) -> CAShapeLayer {
        let heightMultiplier: CGFloat = chordName.show ? 1.3 : 1.2
        let horScale = rect.height / heightMultiplier
        let scale = min(horScale, rect.width)
        let newHeight = scale * heightMultiplier
        let size = CGSize(width: scale, height: newHeight)

        let stringMargin = size.width / 10
        let fretMargin = size.height / 10

        let fretLength = size.width - (stringMargin * 2)
        let stringLength = size.height - (fretMargin * (chordName.show ? 2.8 : 2))
        let origin = CGPoint(x: rect.origin.x, y: chordName.show ? fretMargin * 1.2 : 0)

        let fretSpacing = stringLength / CGFloat(ChordPosition.numberOfFrets)
        let stringSpacing = fretLength / CGFloat(ChordPosition.numberOfStrings)

        let fretConfig = LineConfig(spacing: fretSpacing, margin: fretMargin, length: fretLength, count: ChordPosition.numberOfFrets)
        let stringConfig = LineConfig(spacing: stringSpacing, margin: stringMargin, length: stringLength, count: ChordPosition.numberOfStrings)

        let layer = CAShapeLayer()
        let stringsAndFrets = stringsAndFretsLayer(fretConfig: fretConfig, stringConfig: stringConfig, origin: origin, forScreen: forScreen)
        let barre = barreLayer(fretConfig: fretConfig, stringConfig: stringConfig, origin: origin, showFingers: showFingers, forScreen: forScreen)
        let dots = dotsLayer(stringConfig: stringConfig, fretConfig: fretConfig, origin: origin, showFingers: showFingers, forScreen: forScreen, rect: rect, mirror: mirror)

        layer.addSublayer(stringsAndFrets)
        layer.addSublayer(barre)
        layer.addSublayer(dots)

        if chordName.show {
            let shapeLayer = nameLayer(fretConfig: fretConfig, origin: origin, center: size.width / 2 + origin.x, forScreen: forScreen, name: chordName)
            layer.addSublayer(shapeLayer)
        }

        layer.frame = CGRect(x: 0, y: 0, width: scale, height: newHeight)

        return layer
    }

    private func stringsAndFretsLayer(fretConfig: LineConfig, stringConfig: LineConfig, origin: CGPoint, forScreen: Bool) -> CAShapeLayer {
        let layer = CAShapeLayer()

        let primaryColor = forScreen ? primaryColor.cgColor : SWIFTColor.black.cgColor

        // Strings
        let stringPath = CGMutablePath()

        for string in 0...stringConfig.count {
            let x = stringConfig.spacing * CGFloat(string) + stringConfig.margin + origin.x
            stringPath.move(to: CGPoint(x: x, y: fretConfig.margin + origin.y))
            stringPath.addLine(to: CGPoint(x: x, y: stringConfig.length + fretConfig.margin + origin.y))
        }

        let stringLayer = CAShapeLayer()
        stringLayer.path = stringPath
        stringLayer.lineWidth = stringConfig.spacing / 24
        stringLayer.strokeColor = primaryColor
        layer.addSublayer(stringLayer)

        // Frets
        let fretLayer = CAShapeLayer()

        for fret in 0...fretConfig.count {
            let fretPath = CGMutablePath()
            let lineWidth: CGFloat

            if baseFret == 1 && fret == 0 {
                lineWidth = fretConfig.spacing / 5
            } else {
                lineWidth = fretConfig.spacing / 24
            }

            // Draw fret number
            if baseFret != 1 {
                let txtLayer = CAShapeLayer()
                let txtFont = SWIFTFont.systemFont(ofSize: fretConfig.margin * 0.5)
                let txtRect = CGRect(x: 0, y: 0, width: stringConfig.margin, height: fretConfig.spacing)
                let transX = stringConfig.margin / 5 + origin.x
                let transY = origin.y + (fretConfig.spacing / 2) + fretConfig.margin
                let txtPath = "\(baseFret)".path(font: txtFont, rect: txtRect, position: CGPoint(x: transX, y: transY))
                txtLayer.path = txtPath
                txtLayer.fillColor = primaryColor
                fretLayer.addSublayer(txtLayer)
            }

            let y = fretConfig.spacing * CGFloat(fret) + fretConfig.margin + origin.y
            let x = origin.x + stringConfig.margin
            fretPath.move(to: CGPoint(x: x, y: y))
            fretPath.addLine(to: CGPoint(x: fretConfig.length + x, y: y))

            let fret = CAShapeLayer()
            fret.path = fretPath
            fret.lineWidth = lineWidth
            fret.lineCap = .square
            fret.strokeColor = primaryColor
            fretLayer.addSublayer(fret)
        }

        layer.addSublayer(fretLayer)

        return layer
    }

    private func nameLayer(fretConfig: LineConfig, origin: CGPoint, center: CGFloat, forScreen: Bool, name: Chords.Name) -> CAShapeLayer {

        let primaryColor = forScreen ? primaryColor.cgColor : SWIFTColor.black.cgColor

        var displayKey: String {
            switch name.key {
            case .raw:
                return key.rawValue
            case .accessible:
                return key.display.accessible
            case .symbol:
                return key.display.symbol
            }
        }
        var displaySuffix: String {
            switch name.suffix {
            case .raw:
                return suffix.rawValue
            case .short:
                return suffix.display.short
            case .symbolized:
                return suffix.display.symbolized
            case .altSymbol:
                return suffix.display.altSymbol
            }
        }
        let txtFont = SWIFTFont.systemFont(ofSize: fretConfig.margin, weight: .medium)
        let txtRect = CGRect(x: 0, y: 0, width: fretConfig.length, height: fretConfig.margin + origin.y)
        let transY = (origin.y + fretConfig.margin) * 0.35
        let txtPath = (displayKey + " " + displaySuffix).path(font: txtFont, rect: txtRect, position: CGPoint(x: center, y: transY))
        let shape = CAShapeLayer()
        shape.path = txtPath
        shape.fillColor = primaryColor
        return shape
    }

    private func barreLayer(fretConfig: LineConfig, stringConfig: LineConfig, origin: CGPoint, showFingers: Bool, forScreen: Bool) -> CAShapeLayer {
        let layer = CAShapeLayer()

        let primaryColor = forScreen ? primaryColor.cgColor : SWIFTColor.black.cgColor

        for barre in barres {
            let barrePath = CGMutablePath()

            // draw barre behind all frets that are above the barre chord
            var startIndex = (frets.firstIndex { $0 == barre } ?? 0)
            let barreFretCount = frets.filter { $0 == barre }.count
            var length = 0

            for index in startIndex..<frets.count {
                let dot = frets[index]
                if dot >= barre {
                    length += 1
                } else if dot < barre && length < barreFretCount {
                    length = 0
                    startIndex = index + 1
                } else {
                    break
                }
            }

            let offset = stringConfig.spacing / 7
            let startingX = CGFloat(startIndex) * stringConfig.spacing + stringConfig.margin + (origin.x + offset)
            let y = CGFloat(barre) * fretConfig.spacing + fretConfig.margin - (fretConfig.spacing / 2) + origin.y

            barrePath.move(to: CGPoint(x: startingX, y: y))

            let endingX = startingX + (stringConfig.spacing * CGFloat(length)) - stringConfig.spacing - (offset * 2)
            barrePath.addLine(to: CGPoint(x: endingX, y: y))

            let barreLayer = CAShapeLayer()
            barreLayer.path = barrePath
            barreLayer.lineCap = .round
            barreLayer.lineWidth = fretConfig.spacing * 0.65
            barreLayer.strokeColor = primaryColor

            layer.addSublayer(barreLayer)

            if showFingers {
                let fingerLayer = CAShapeLayer()
                let txtFont = SWIFTFont.systemFont(ofSize: stringConfig.margin, weight: .medium)
                let txtRect = CGRect(x: 0, y: 0, width: stringConfig.spacing, height: fretConfig.spacing)
                let transX = startingX + ((endingX - startingX) / 2)
                let transY = y

                if let fretIndex = frets.firstIndex(of: barre) {
                    let txtPath = "\(fingers[fretIndex])".path(font: txtFont, rect: txtRect, position: CGPoint(x: transX, y: transY))
                    fingerLayer.path = txtPath
                }
                fingerLayer.fillColor = primaryColor
                layer.addSublayer(fingerLayer)
            }
        }

        return layer
    }

    private func dotsLayer(stringConfig: LineConfig, fretConfig: LineConfig, origin: CGPoint, showFingers: Bool, forScreen: Bool, rect: CGRect, mirror: Bool) -> CAShapeLayer {
        let layer = CAShapeLayer()

        let primaryColor = forScreen ? primaryColor.cgColor : SWIFTColor.black.cgColor
        let backgroundColor = forScreen ? backgroundColor.cgColor : SWIFTColor.black.cgColor

        for index in 0..<frets.count {
            let fret = frets[index]

            // Draw circle above nut ⭕️
            if fret == 0 {
                let size = fretConfig.spacing * 0.33
                let circleX = ((CGFloat(index) * stringConfig.spacing + stringConfig.margin) - size / 2 + origin.x).shouldMirror(mirror, offset: rect.width - size)
                let circleY = fretConfig.margin - size * 1.6 + origin.y

                let center = CGPoint(x: circleX, y: circleY)
                let frame = CGRect(origin: center, size: CGSize(width: size, height: size))

                let circle = CGMutablePath(roundedRect: frame, cornerWidth: frame.width/2, cornerHeight: frame.height/2, transform: nil)

                let circleLayer = CAShapeLayer()
                circleLayer.path = circle
                circleLayer.lineWidth = fretConfig.spacing / 24
                circleLayer.strokeColor = primaryColor
                circleLayer.fillColor = backgroundColor

                layer.addSublayer(circleLayer)

                continue
            }

            // Draw cross above nut ❌
            if fret == -1 {
                let size = fretConfig.spacing * 0.33
                let crossX = ((CGFloat(index) * stringConfig.spacing + stringConfig.margin) - size / 2 + origin.x).shouldMirror(mirror, offset: rect.width - size)
                let crossY = fretConfig.margin - size * 1.6 + origin.y

                let center = CGPoint(x: crossX, y: crossY)
                let frame = CGRect(origin: center, size: CGSize(width: size, height: size))

                let cross = CGMutablePath()

                cross.move(to: CGPoint(x: frame.minX, y: frame.minY))
                cross.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))

                cross.move(to: CGPoint(x: frame.maxX, y: frame.minY))
                cross.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))

                let crossLayer = CAShapeLayer()
                crossLayer.path = cross
                crossLayer.lineWidth = fretConfig.spacing / 24

                crossLayer.strokeColor = primaryColor

                layer.addSublayer(crossLayer)

                continue
            }

            if barres.contains(fret) {
                if index + 1 < frets.count {
                    let next = index + 1
                    if frets[next] >= fret {
                        continue
                    }
                }

                if index - 1 > 0 {
                    let prev = index - 1
                    if frets[prev] >= fret {
                        continue
                    }
                }
            }

            let dotY = CGFloat(fret) * fretConfig.spacing + fretConfig.margin - (fretConfig.spacing / 2) + origin.y
            let dotX = (CGFloat(index) * stringConfig.spacing + stringConfig.margin + origin.x).shouldMirror(mirror, offset: rect.width)

            let dotPath = CGMutablePath()
            dotPath.addArc(center: CGPoint(x: dotX, y: dotY), radius: fretConfig.spacing * 0.35, startAngle: 0, endAngle: .pi * 2, clockwise: true)

            let dotLayer = CAShapeLayer()
            dotLayer.path = dotPath
            dotLayer.fillColor = primaryColor

            layer.addSublayer(dotLayer)

            if showFingers {
                let txtFont = SWIFTFont.systemFont(ofSize: stringConfig.margin, weight: .medium)

                let txtRect = CGRect(x: 0, y: 0, width: stringConfig.spacing, height: fretConfig.spacing)
                let txtPath = "\(fingers[index])".path(font: txtFont, rect: txtRect, position: CGPoint(x: dotX, y: dotY))
                let txtLayer = CAShapeLayer()
                txtLayer.path = txtPath
                txtLayer.fillColor = backgroundColor

                layer.addSublayer(txtLayer)
            }
        }

        return layer
    }

}


extension CGFloat {
    func shouldMirror(_ mirror: Bool, offset: CGFloat) -> CGFloat {
        if mirror {
            return self * -1 + offset
        } else {
            return self
        }
    }
}
