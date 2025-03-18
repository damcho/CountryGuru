//
//  ContentView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

class InquiryViewModel: Identifiable {
    
}

class InquiryChatScreenViewModel: ObservableObject {
    @Published var inquiries: [InquiryViewModel] = []
    
    func ask(question: String) {
        inquiries.append(InquiryViewModel())
    }
}

struct InquiryChatScreen: View {
    @StateObject var viewModel: InquiryChatScreenViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.inquiries) { inquiryViewModel in
                    QuestionAnswerView()
                }

            }
            TextInputView(onSendAction: {text in
                viewModel.ask(question: text)
            })
        }
        .padding()
    }
}

#Preview {
    InquiryChatScreen(viewModel: InquiryChatScreenViewModel())
}
