//
//  ViewExtensions.swift
//  FlashZilla
//
//  Created by Robert Martinez on 12/17/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }

    func backgroundGradient() -> some View {
        self
            .background(LinearGradient(colors: [.mint, .gray, .black], startPoint: .top, endPoint: .bottom))
    }

    func titleStyle() -> some View {
        self
            .font(.system(size: 48))
            .fontWidth(.condensed)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
    }

    func subtitleStyle() -> some View {
        self
            .font(.title.bold())
            .padding(.bottom, 40)
    }
}

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2.bold())
            .foregroundStyle(configuration.isPressed ? .white : .blue)
            .padding(8)
            .padding(.horizontal, 10)
            .background(configuration.isPressed ? .blue : .white)
            .clipShape(.capsule)
    }
}

extension ButtonStyle where Self == PrimaryButton {
    static var primary: PrimaryButton {
        PrimaryButton()
    }
}
