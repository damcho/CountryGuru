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
            Spacer()
            content.frame(maxWidth: 200, alignment: .trailing)
        }
    }
}

extension View {
    func receiverMessageAlignment() -> some View {
        modifier(ReceiverMessageView())
    }
}
