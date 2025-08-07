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
    let dummyLastRow: some View = Color.clear
        .frame(height: 1)
        .id("bottom")
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.rows) { row in
                            AnyView(
                                row.message.toChatMessageView()
                            )
                        }
                        dummyLastRow
                    }
                    .scrollTargetLayout()
                }
                .padding(.horizontal)
                .onChange(of: viewModel.responseLoadedTrigger) {
                    scrollToBottom(proxy)
                }
                .onAppear {
                    scrollToBottom(proxy)
                }
            }

            TextInputView(onSendAction: { text in
                viewModel.ask(question: text)
            })
        }
        .padding()
    }

    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("bottom", anchor: .bottom)
        }
    }
}

#Preview {
    InquiryChatScreen(viewModel: InquiryChatScreenViewModel(
        inquiryResolverFactory: {
            InquiryResponseViewModel(with: DummyQuestionHandable())
        }
    ))
}

struct DummyQuestionHandable: QuestionHandable {
    func didAskRaw(_ question: String) async throws -> CountryGuruCore.QueryResponse {
        .text("a response")
    }
}
