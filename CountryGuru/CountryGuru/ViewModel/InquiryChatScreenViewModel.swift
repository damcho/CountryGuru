//
//  InquiryChatScreenViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation

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
        inquiries.append(ChatRow(sender: question))
        inquiries.append(ChatRow(receiver: newInquiryViewModel))
        _ = newInquiryViewModel.didAsk(question)
        // onQuestionResponse()
    }
}
