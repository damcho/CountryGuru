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
    let inquiryViewModel = InquiryViewModel(questionHandler: { _ in
            .text("all good here")
    })
    let view = QuestionAnswerView(viewModel: inquiryViewModel)
    _ = inquiryViewModel.didAsk("how are you?")
    return view
}
