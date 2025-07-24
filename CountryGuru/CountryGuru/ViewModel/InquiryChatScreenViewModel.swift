//
//  InquiryChatScreenViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation

typealias InquiryHandler = (String) async throws -> QueryResponse
typealias InquiryResolverFactory = () -> InquiryResponseViewModel

@MainActor
class InquiryChatScreenViewModel: ObservableObject {
    @Published var rows: [IdentifiableChatRow] = []
    let inquiryResolverFactory: InquiryResolverFactory

    init(inquiryResolverFactory: @escaping InquiryResolverFactory) {
        self.inquiryResolverFactory = inquiryResolverFactory
    }

    func ask(question: String, onQuestionResponse: @escaping () -> Void) {
        let inquiryResolver = inquiryResolverFactory()
        rows.append(IdentifiableChatRow(message: question))
        rows.append(IdentifiableChatRow(message: inquiryResolver))

        Task.detached {
            await inquiryResolver.ask(question)
            await MainActor.run {
                onQuestionResponse()
            }
        }
    }
}
