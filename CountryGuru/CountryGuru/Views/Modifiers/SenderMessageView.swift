//
//  SenderMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct SenderMessageView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(maxWidth: 280, alignment: .leading)
            Spacer(minLength: 60)
        }
        .padding(.horizontal, 4)
    }
}

extension View {
    func senderMessageAlignment() -> some View {
        modifier(SenderMessageView())
    }
}
