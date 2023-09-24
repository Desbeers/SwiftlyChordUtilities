//
//  ContentView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI

struct ContentView: View {
    /// The selected router item
    @State var router: Router? = .database
    /// The body of the `View`
    var body: some View {
        NavigationSplitView(
            sidebar: {
                SidebarView(router: $router)
                    .navigationTitle("Chords Demo")
#if !os(macOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            },
            detail: {
                DetailView(router: $router)
#if os(macOS)
                    .navigationSubtitle(router?.item.title ?? "Welcome")
#else
                    .navigationTitle(router?.item.title ?? "Welcome")
#endif
            })
    }
}
