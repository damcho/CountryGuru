//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import Foundation
import SwiftUI
import CountryGuruCore

class InquiryViewModel: ObservableObject {
    let questionHandler: InquiryHandler
    
    @Published var receiverView: any View = ProgressView()
    
    init(questionHandler: @escaping InquiryHandler) {
        self.questionHandler = questionHandler
    }

    func didAsk(_ question: String) async {
        do {
            receiverView = try await questionHandler(question).toView()
        } catch is HTTPClientError {
            receiverView = await RetryView()
        } catch {
            receiverView = TextMessageView(message: "This question is not supported")
        }
    }
}
