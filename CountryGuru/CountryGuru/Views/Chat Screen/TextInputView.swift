//
//  TextInputView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct TextInputView: View {
    let onSendAction: (String) -> Void
    @State private var message: String = ""

    var body: some View {
        HStack {
            TextField(
                "Ask a question...",
                text: $message
            )
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .textInputAutocapitalization(.never)

            Button(action: {
                onSendAction(message)
                message = ""
            }, label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(message.isEmpty ? .gray : .blue)
                    .padding(10)
            }).disabled(message.isEmpty)

        }.padding()
    }
}

#Preview {
    TextInputView(onSendAction: { _ in })
}
