//
//  QuestionInterpreterAdapter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

public protocol QuestionHandable {
    func didAskRaw(_ question: String) async throws -> QueryResponse
}

public struct QuestionInterpreterAdapter {
    let inquiryLoader: InquiryLoadable
    let inquiryInterpreter: InquiryInterpreter
}

// MARK: QuestionHandable

extension QuestionInterpreterAdapter: QuestionHandable {
    public func didAskRaw(_ question: String) async throws -> QueryResponse {
        try await inquiryLoader.didAsk(inquiryInterpreter.inquiry(from: question))
    }
}
