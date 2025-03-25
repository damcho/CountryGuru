//
//  ContentView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI
import CountryGuruCore

struct InquiryChatScreen: View {
    @StateObject var viewModel: InquiryChatScreenViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.inquiries) { inquiryViewModel in
                    QuestionAnswerView(
                        viewModel: inquiryViewModel
                    )
                }

            }
            TextInputView(onSendAction: {text in
                viewModel.ask(question: text)
            })
        }
        .padding()
    }
}

#Preview {
    InquiryChatScreen(viewModel: InquiryChatScreenViewModel(
        inquiryViewModelFactory: {
            InquiryViewModel { _ in .text(" a response")}
    }))
}
