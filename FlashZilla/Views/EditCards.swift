//
//  EditCards.swift
//  FlashZilla
//
//  Created by Robert Martinez on 6/21/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = DataManager.load()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                        .disabled(newPrompt.isEmpty || newAnswer.isEmpty)
                }

                Section("Current Cards") {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)

                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .toolbar {

                Button("Done") {
                    showingAlert = true
                }
                .alert("Confirm?", isPresented: $showingAlert) {
                    Button("Done") { done() }
                    Button("Cancel", role: .cancel) { }
                }
            }
            .listStyle(.grouped)
        }
    }

    func done() {
        dismiss()
    }

    func addCard() {
        withAnimation {
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

            let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
            cards.insert(card, at: 0)
            DataManager.save(cards)

            newPrompt = ""
            newAnswer = ""
        }
    }

    func removeCards(at offsets: IndexSet) {
        withAnimation {
            cards.remove(atOffsets: offsets)
            DataManager.save(cards)
        }
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
