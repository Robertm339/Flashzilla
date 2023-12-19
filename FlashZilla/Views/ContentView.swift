//
//  ContentView.swift
//  FlashZilla
//
//  Created by Robert Martinez on 6/18/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\._accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(ViewModel.self) var viewModel
    @Environment(\.scenePhase) var scenePhase

    @State private var showingEditScreen = false

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ForEach(Array(viewModel.cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { reinsert in
                            withAnimation {
                                removeCard(at: item.offset, reinsert: reinsert)
                            }
                        }
                        .stacked(at: item.offset, in: viewModel.cards.count)
                        .allowsHitTesting(item.offset == viewModel.cards.count - 1)
                        .accessibilityHidden(item.offset < viewModel.cards.count - 1)
                    }
                    .padding(.bottom, 30)
                }
                .allowsHitTesting(viewModel.timeRemaining > 0)

                if viewModel.cards.isEmpty {
                    Button("Start Again", action: viewModel.resetCards)
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }

//                Text("Time: \(viewModel.timeRemaining)")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 5)
//                    .background(.black.opacity(0.75))
//                    .clipShape(Capsule())
            }

            VStack {
                HStack {

                    Spacer()

                    Button {
                        viewModel.end()
                    } label: {
                        Image(systemName: "house")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: viewModel.cards.count - 1, reinsert: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")

                        Spacer()

                        Button {
                            withAnimation {
                                removeCard(at: viewModel.cards.count - 1, reinsert: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .backgroundGradient()
        .onReceive(viewModel.timer) { _ in
            guard viewModel.isActive else { return }

            if viewModel.timeRemaining > 0 {
                viewModel.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase, _ in
            if newPhase == .active {
                if viewModel.cards.isEmpty == false {
                    viewModel.isActive = true
                }
            } else {
                viewModel.isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: viewModel.resetCards, content: EditCards.init)
        .onAppear(perform: viewModel.resetCards)
    }

    func removeCard(at index: Int, reinsert: Bool) {
        guard index >= 0 else { return }

        if reinsert {
            viewModel.cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            viewModel.cards.remove(at: index)
        }

        if viewModel.cards.isEmpty {
            viewModel.isActive = false
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(ViewModel())
    }
}
