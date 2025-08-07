//
//  ResponseView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

extension InquiryResponseViewModel {
    var isError: Bool {
        if case .error = state {
            return true
        }
        return false
    }
}

struct ResponseView: View {
    @StateObject var viewModel: InquiryResponseViewModel
    var body: some View {
        AnyView(
            viewModel.state.toView()
        )
        .addChatBubble(sender: false, error: viewModel.isError)
        .receiverMessageAlignment()
    }
}

#Preview {
    ResponseView(
        viewModel: InquiryResponseViewModel(with: DummyQuestionHandable())
    )
}
