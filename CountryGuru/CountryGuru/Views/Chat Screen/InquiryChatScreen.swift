//
//  InquiryChatScreen.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import CountryGuruCore
import SwiftUI

struct InquiryChatScreen: View {
    @StateObject var viewModel: InquiryChatScreenViewModel
    @State private var scrollPosition: ChatRow.ID?

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.inquiries) { inquiry in
                        if let question = inquiry.sender {
                            TextMessageView(message: question)
                                .addChatBubble(sender: true)
                                .senderMessageAlignment()

                        } else if let response = inquiry.receiver {
                            ResponseView(viewModel: response)
                                .addChatBubble(sender: false)
                                .receiverMessageAlignment()
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition, anchor: .bottom)
            TextInputView(onSendAction: { text in
                viewModel.ask(question: text, onQuestionResponse: {
                    scrollPosition = viewModel.inquiries.last?.id
                })
                scrollPosition = viewModel.inquiries.last?.id
            })
        }
        .padding()
    }
}

#Preview {
    InquiryChatScreen(viewModel: InquiryChatScreenViewModel(
        inquiryViewModelFactory: {
            InquiryViewModel { _ in .text(" a response") }
        }
    ))
}
