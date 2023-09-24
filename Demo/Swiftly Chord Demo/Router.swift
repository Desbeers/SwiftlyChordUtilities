//
//  Router.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI

enum Router: Hashable, CaseIterable {
    case database
    case create
    case define
    case lookup
}

extension Router {

    /// Structure for a ``Router`` Item
    struct Item {
        /// Title of the item
        public var title: String = "Title"
        /// Description of the item
        public var description: String = "Description"
        /// Loading message of the item
        public var loading: String = "Loading"
        /// Message when the item is empty
        public var empty: String = "Empty"
        /// The SF symbol for the item
        public var icon: String = "square.dashed"
    }
}

extension Router {

    /// Details of the router item
    var item: Item {
        switch self {

        case .database:
            return Item(
                title: "Browse the database",
                description: "Browse all the chords in the database",
                loading: "Loading the chords",
                empty: "No chords found",
                icon: "square.stack.3d.up"
            )
        case .create:
            return Item(
                title: "Create a chord",
                description: "Create your own chord with pickers",
                loading: "Loading the chord",
                empty: "No chord found",
                icon: "square.stack.3d.up"
            )
        case .define:
            return Item(
                title: "Define a chord",
                description: "Define a chord in the **ChordPro** format",
                loading: "Rendering the chord",
                empty: "I could not make a chord from this definition",
                icon: "square.and.pencil"
            )
        case .lookup:
            return Item(
                title: "Lookup a chord",
                description: "Lookup a chord in the database by its name",
                loading: "Lookup the chord",
                empty: "This chord was not found in the database",
                icon: "magnifyingglass"
            )
        }
    }
}

extension Router {

    /// An empty message `View`
    var emptyMessage: some View {
        VStack {
            Text(self.item.empty)
                .font(.title)
            Image(systemName: "questionmark.app")
                .font(.system(size: 200, weight: .thin, design: .default))
        }
        .padding()
    }
}
