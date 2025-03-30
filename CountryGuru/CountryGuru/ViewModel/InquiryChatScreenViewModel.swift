//
//  InquiryChatScreenViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

typealias InquiryHandler = (String) async throws -> QueryResponse
typealias InquiryViewModelFactory = () -> InquiryViewModel

@MainActor
class InquiryChatScreenViewModel: ObservableObject {
    @Published var inquiries: [ChatRow] = []
    let inquiryViewModelFactory: InquiryViewModelFactory

    init(inquiryViewModelFactory: @escaping InquiryViewModelFactory) {
        self.inquiryViewModelFactory = inquiryViewModelFactory
    }

    func ask(question: String, onQuestionResponse: @escaping () -> Void) {
        let newInquiryViewModel = inquiryViewModelFactory()
        inquiries.append(ChatRow(sender: AnyView(TextMessageView(message: question))))
        inquiries.append(ChatRow(receiver: AnyView(ProgressView())))

        Task {
            await newInquiryViewModel.didAsk(question)
            inquiries.removeLast()
            inquiries.append(ChatRow(receiver: AnyView(newInquiryViewModel.receiverView)))
            onQuestionResponse()
        }
    }
}
