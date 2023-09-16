//
//  ContentView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI

struct ContentView: View {

    @State var router: Router? = .database

    var body: some View {
        NavigationSplitView(
            sidebar: {
                SidebarView(router: $router)
                    .navigationTitle("Chords Demo")
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
