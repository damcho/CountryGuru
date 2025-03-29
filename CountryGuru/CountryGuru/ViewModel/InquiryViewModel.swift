//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

@MainActor
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
            receiverView = RetryView(
                onRetry: { [weak self] in
                    Task {
                        await self?.didAsk(question)
                    }
                }
            )
        } catch {
            receiverView = TextMessageView(
                message: "This question is not supported"
            )
        }
    }
}
