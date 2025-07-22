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
                    ForEach(viewModel.rows) { row in
                        InquiryView(chatRow: row)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition, anchor: .bottom)
            TextInputView(onSendAction: { text in
                viewModel.ask(question: text, onQuestionResponse: {
                    withAnimation {
                        scrollPosition = viewModel.rows.last?.id
                    }
                })
                scrollPosition = viewModel.rows.last?.id
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
