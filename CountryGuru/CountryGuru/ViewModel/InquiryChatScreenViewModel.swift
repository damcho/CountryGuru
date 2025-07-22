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
    @Published var rows: [ChatRow] = []
    let inquiryViewModelFactory: InquiryViewModelFactory

    init(inquiryViewModelFactory: @escaping InquiryViewModelFactory) {
        self.inquiryViewModelFactory = inquiryViewModelFactory
    }

    func ask(question: String, onQuestionResponse: @escaping () -> Void) {
        let newInquiryViewModel = inquiryViewModelFactory()
        rows.append(ChatRow(sender: question))
        rows.append(ChatRow(receiver: newInquiryViewModel))

        Task.detached {
            await newInquiryViewModel.ask(question)
            await MainActor.run {
                onQuestionResponse()
            }
        }
    }
}
