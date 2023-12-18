//
//  GameOverView.swift
//  FlashZilla
//
//  Created by Robert Martinez on 12/18/23.
//

import SwiftUI

struct GameOverView: View {
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Game over!")
                .titleStyle()
            
            Text("Time left: \(viewModel.timeRemaining)")
                .subtitleStyle()
            
            Button("Play Again", action: viewModel.end)
                .buttonStyle(.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundGradient()
    }
}

#Preview {
    GameOverView()
        .environment(ViewModel())
}
