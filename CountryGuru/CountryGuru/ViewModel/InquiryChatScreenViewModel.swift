//
//  InquiryChatScreenViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import Foundation
import CountryGuruCore

typealias InquiryHandler = (String) async throws -> QueryResponse

class InquiryChatScreenViewModel: ObservableObject {
    @Published var inquiries: [InquiryViewModel] = []
    let questionLoader: InquiryHandler
    
    init(questionLoader: @escaping InquiryHandler) {
        self.questionLoader = questionLoader
    }
    
    func ask(question: String) {
        let newInquiryViewModel = InquiryViewModel { _ in
                .text("a response")
        }
        inquiries.append(newInquiryViewModel)
    }

}
