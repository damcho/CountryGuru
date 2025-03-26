//
//  QuestionAnswerView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct QuestionAnswerView: View {
    @StateObject var viewModel: InquiryViewModel
    
    var body: some View {
        VStack {
            TextMessageView(
                message: viewModel.inquiry
            )
            .addChatBubble(sender: true)
            .senderMessageAlignment()
            AnyView(
                viewModel.receiverView
                    .addChatBubble(
                        sender: false
                    )
                    .receiverMessageAlignment()
            )
        }
    }
}

#Preview {
    QuestionAnswerView(viewModel: InquiryViewModel(questionHandler: { _ in
            .text("hello world")
    }))
}
