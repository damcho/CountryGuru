//
//  ResponseView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

struct ResponseView: View {
    @StateObject var viewModel: InquiryViewModel
    var body: some View {
        AnyView(
            viewModel.state.toView()
        )
    }
}

#Preview {
    ResponseView(
        viewModel: InquiryViewModel(
            questionHandler: { _ in
                .text("hello world")
            }
        )
    )
}
