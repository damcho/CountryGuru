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
        VStack(spacing: 0) {
            // Header
            headerView

            // Chat Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.rows) { row in
                            AnyView(
                                row.message.toChatMessageView()
                            )
                        }
                        dummyLastRow
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                .onChange(of: viewModel.scrollTrigger) {
                    scrollToBottom(proxy)
                }
                .onAppear {
                    scrollToBottom(proxy)
                }
            }
            .background(Color.secondary.opacity(0.05))

            // Input View
            TextInputView(onSendAction: { text in
                viewModel.ask(question: text)
            })
            .background(Color.primary.opacity(0.05))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: -2)
        }
        .navigationBarHidden(true)
    }

    private var headerView: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CountryGuru")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("Ask me anything about countries")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // App icon or decorative element
                Image(systemName: "globe.americas.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(width: 44, height: 44)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider()
        }
        .background(Color.primary.opacity(0.05))
    }

    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        withAnimation(.easeInOut(duration: 0.3)) {
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
