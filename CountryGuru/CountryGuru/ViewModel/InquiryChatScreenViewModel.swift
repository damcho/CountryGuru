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
    var inquityTask: Task<Void, Never>? = nil

    init(inquiryResolverFactory: @escaping InquiryResolverFactory) {
        self.inquiryResolverFactory = inquiryResolverFactory
    }

    func ask(question: String, onInquiryResponse: @escaping () -> Void) {
        inquityTask?.cancel()
        let inquiryResolver = inquiryResolverFactory()
        rows.append(IdentifiableChatRow(message: question))
        rows.append(IdentifiableChatRow(message: inquiryResolver))

        inquityTask = Task.detached {
            await inquiryResolver.ask(question)
            if Task.isCancelled { return }
            await MainActor.run {
                onInquiryResponse()
            }
        }
    }
}
