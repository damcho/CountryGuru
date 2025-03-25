//
//  InquiryChatScreenViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import Foundation
import CountryGuruCore

typealias InquiryHandler = (String) async throws -> QueryResponse
typealias InquiryViewModelFactory = () -> InquiryViewModel

class InquiryChatScreenViewModel: ObservableObject {
    @Published var inquiries: [InquiryViewModel] = []
    let inquiryViewModelFactory: InquiryViewModelFactory
    
    init(inquiryViewModelFactory: @escaping InquiryViewModelFactory) {
        self.inquiryViewModelFactory = inquiryViewModelFactory
    }
    
    func ask(question: String) {
        let newInquiryViewModel = inquiryViewModelFactory()
        inquiries.append(newInquiryViewModel)
        _ = newInquiryViewModel.didAsk(question)
    }
}
