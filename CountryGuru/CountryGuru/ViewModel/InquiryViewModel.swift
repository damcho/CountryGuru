//
//  InquiryViewModel.swift
//  CountryGuru
//
//  Created by Damian Modernell on 24/3/25.
//

import CountryGuruCore
import Foundation
import SwiftUI

typealias InquiryChatHandler = (String) async -> Void

enum ResponseState {
    case processing
    case success(QueryResponse)
    case error(InquiryChatHandler, String)
    case notSupported
}

@MainActor
class InquiryViewModel: ObservableObject {
    let questionHandler: InquiryHandler

    @Published var state: ResponseState = .processing

    init(questionHandler: @escaping InquiryHandler) {
        self.questionHandler = questionHandler
    }

    func ask(_ question: String) async {
        do {
            state = try await .success(questionHandler(question))
        } catch is HTTPClientError {
            state = .error(ask, question)
        } catch {
            state = .notSupported
        }
    }
}
