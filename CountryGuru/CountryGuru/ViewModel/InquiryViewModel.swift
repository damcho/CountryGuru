//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import Foundation
import SwiftUI

class InquiryViewModel: Identifiable, ObservableObject {
    let questionHandler: InquiryHandler
    
    @Published var receiverView: any View = EmptyView()
    @Published var inquiry: String = ""
    
    init(questionHandler: @escaping InquiryHandler) {
        self.questionHandler = questionHandler
    }

    func didAsk(_ question: String) -> Task<Void, Error>{
        inquiry = question
        return Task {
            _ = try await questionHandler(question)
        }
    }
}
