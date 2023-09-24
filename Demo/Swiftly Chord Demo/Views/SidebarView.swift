//
//  SidebarView.swift
//  Swiftly Chord Demo
//
//  © 2023 Nick Berendsen
//

import SwiftUI

struct SidebarView: View {
    /// The selected router item
    @Binding var router: Router?
    /// The body of the `View`
    var body: some View {
        List(selection: $router) {
                ForEach(Router.allCases, id: \.self) { route in
                    sidebarItem(router: route)
                }
            Section("Display Options") {
                DisplayOptionsView()
            }
        }
    }

    /// SwiftUI `View` for an item in the sidebar
    /// - Parameter router: The ``Router`` item
    /// - Returns: A SwiftUI `View` with the sidebar item
    private func sidebarItem(router: Router) -> some View {
        Label(title: {
            VStack(alignment: .leading) {
                Text(router.item.title)
                    .lineLimit(nil)
                    .font(.headline)
                Text(.init(router.item.description))
                    .lineLimit(nil)
                    .foregroundStyle(.secondary)
            }
        }, icon: {
            Image(systemName: router.item.icon)
        })
        .tag(router)
    }
}
