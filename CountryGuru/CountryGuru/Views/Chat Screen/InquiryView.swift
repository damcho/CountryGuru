//
//  InquiryView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 21/7/25.
//

import SwiftUI

struct InquiryView: View {
    @StateObject var chatRow: ChatRow
    var body: some View {
        if let question = chatRow.sender {
            TextMessageView(message: question)
                .addChatBubble(sender: true)
                .senderMessageAlignment()

        } else if let response = chatRow.receiver {
            ResponseView(viewModel: response)
                .addChatBubble(sender: false)
                .receiverMessageAlignment()
        }
    }
}

#Preview {
    InquiryView(chatRow: ChatRow(sender: "Hello"))
}

#Preview {
    let viewmodel = InquiryViewModel(
        questionHandler: { _ in .text("text question response") }
    )
    Task {
        await viewmodel.ask("A question")
    }
    return InquiryView(
        chatRow: ChatRow(
            receiver: viewmodel
        )
    )
}
