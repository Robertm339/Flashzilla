//
//  HomeView.swift
//  FlashZilla
//
//  Created by Robert Martinez on 12/18/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        switch viewModel.playState {
        case .menu:
            MenuView()
            
        case .playing:
            ContentView()
            
        case .gameOver:
            GameOverView()
        }
    }
}

#Preview {
    HomeView()
        .environment(ViewModel())
}
