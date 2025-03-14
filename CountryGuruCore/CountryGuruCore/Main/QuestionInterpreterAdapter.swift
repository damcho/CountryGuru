//
//  QuestionInterpreterAdapter.swift
//  CountryGuruCore
//
//  Created by Damian Modernell on 14/3/25.
//

struct QuestionInterpreterAdapter {
    let inquiryLoader: InquiryLoadable
    let inquiryInterpreter: InquiryInterpreter
    
    func didAskRaw(_ question: String) async throws -> QueryResponse {
        try await inquiryLoader.didAsk(inquiryInterpreter.inquiry(from: question))
    }
}
