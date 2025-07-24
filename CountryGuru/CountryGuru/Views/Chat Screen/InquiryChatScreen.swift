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
    @State private var scrollTrigger: UUID?
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
                .onChange(of: scrollTrigger) {
                    scrollToBottom(proxy)
                }
                .onAppear {
                    scrollToBottom(proxy)
                }
            }

            TextInputView(onSendAction: { text in
                viewModel.ask(question: text, onQuestionResponse: {
                    scrollTrigger = UUID()
                })
                scrollTrigger = UUID()
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
            InquiryResponseViewModel { _ in .text(" a response") }
        }
    ))
}
