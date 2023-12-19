//
//  FlashZillaApp.swift
//  FlashZilla
//
//  Created by Robert Martinez on 6/18/22.
//

import SwiftUI

@main
struct FlashZillaApp: App {
    @State private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(viewModel)
        }
    }
}
