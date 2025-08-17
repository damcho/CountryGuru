//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

typealias InquiryChatHandler = @Sendable (String) async -> Void

enum ResponseState: Sendable {
    case processing
    case success(QueryResponse)
    case error(InquiryChatHandler, String)
    case notSupported
}

@MainActor
class InquiryResponseViewModel: ObservableObject {
    nonisolated(unsafe) let questionHandler: QuestionHandable

    @Published var state: ResponseState = .processing

    init(with questionHandler: QuestionHandable) {
        self.questionHandler = questionHandler
    }

    func ask(_ question: String) async {
        do {
            state = try await .success(questionHandler.didAskRaw(question))
        } catch HTTPClientError.notFound {
            state = .notSupported
        } catch {
            state = .error(ask, question)
        }
    }
}

// MARK: ViewableChatMessage

extension InquiryResponseViewModel: ViewableChatMessage {
    nonisolated func toChatMessageView() -> some View {
        ResponseView(viewModel: self)
    }
}
