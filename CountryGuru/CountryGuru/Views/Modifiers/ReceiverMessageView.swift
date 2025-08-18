//
//  ReceiverMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct ReceiverMessageView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer(minLength: 60)
            content
                .frame(maxWidth: 280, alignment: .trailing)
        }
        .padding(.horizontal, 4)
    }
}

extension View {
    func receiverMessageAlignment() -> some View {
        modifier(ReceiverMessageView())
    }
}
