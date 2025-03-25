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
            ).senderMessageAlignment()
            AnyView(
                viewModel.receiverView
            )
        }
    }
}

#Preview {
    QuestionAnswerView(viewModel: InquiryViewModel(questionHandler: { _ in
            .text("hello world")
    }))
}
