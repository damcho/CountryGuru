//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

class InquiryViewModel: Identifiable {
    let questionHandler: InquiryHandler
    init(questionHandler: @escaping InquiryHandler) {
        self.questionHandler = questionHandler
    }

    func didAsk(_ question: String) -> Task<Void, Error>{
        Task {
            _ = try await questionHandler(question)
        }
    }
}
