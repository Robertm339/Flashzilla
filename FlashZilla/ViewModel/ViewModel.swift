//
//  ViewModel.swift
//  FlashZilla
//
//  Created by Robert Martinez on 12/18/23.
//

import Foundation

@Observable
class ViewModel {
    enum PlayState {
        case menu, playing
    }

    private(set) var playState = PlayState.menu
    var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var cards = DataManager.load()
    var isActive = true

    func start() {
        playState = .playing
        timeRemaining = 100
    }

    func end() {
        playState = .menu
    }

    func resetCards() {
        isActive = true
        cards = DataManager.load()
    }
}
