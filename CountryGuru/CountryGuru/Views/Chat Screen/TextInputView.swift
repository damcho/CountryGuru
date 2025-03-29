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
                "",
                text: $message
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)

            Button("Send") {
                onSendAction(message)
                message = ""
            }.disabled(message.isEmpty)
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    TextInputView(onSendAction: { _ in })
}
