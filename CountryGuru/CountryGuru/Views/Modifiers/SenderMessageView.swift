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
            content.frame(maxWidth: 200, alignment: .leading)
            Spacer()
        }.padding()
    }
}

extension View {
    func senderMessageAlignment() -> some View {
        modifier(SenderMessageView())
    }
}
