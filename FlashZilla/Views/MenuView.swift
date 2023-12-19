//
//  MenuView.swift
//  FlashZilla
//
//  Created by Robert Martinez on 12/18/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(ViewModel.self) var viewModel

    @State private var showingSheet = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                //                Image(.logo)
                //                    .clipShape(.rect(cornerRadius: 16))
                //                    .padding(.bottom, 20)
                //                    .phaseAnimator([false, true]) { content, phase in
                //                        content
                //                            .shadow(color: .purple, radius: phase ? 20: 40)
                //                    } animation: { _ in
                //                            .easeInOut(duration: 1)
                //                    }

                Text("FlashZilla")
                    .titleStyle()

                Button("Start Learing", action: viewModel.start)
                    .buttonStyle(.primary)

                Button("Edit Cards") {
                    showingSheet = true
                }
                .buttonStyle(.primary)
                .sheet(isPresented: $showingSheet, content: EditCards.init)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundGradient()
        }
    }
}

#Preview {
    MenuView()
        .environment(ViewModel())
}
