//
//  ReceiverTextMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 7/8/25.
//

import SwiftUI

struct ReceiverTextMessageView: View {
    let text: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(text)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                    )
                    .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)
            }

            Spacer(minLength: 60)
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    VStack(spacing: 16) {
        ReceiverTextMessageView(text: "What is the capital of France?")
        ReceiverTextMessageView(text: "Show me the flag of Brazil")
        ReceiverTextMessageView(text: "This is a longer message to test how the bubble handles multiple lines of text")
    }
    .padding()
    .background(Color.secondary.opacity(0.05))
}
