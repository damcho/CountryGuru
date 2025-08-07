//
//  ResponseView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

struct ResponseView: View {
    @StateObject var viewModel: InquiryResponseViewModel
    var body: some View {
        AnyView(
            viewModel.state.toView()
        )
        .addChatBubble(sender: false)
        .receiverMessageAlignment()
    }
}

#Preview {
    ResponseView(
        viewModel: InquiryResponseViewModel(with: DummyQuestionHandable())
    )
}
