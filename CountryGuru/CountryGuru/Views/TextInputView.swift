//
//  TextInputView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

class TextInputViewModel {
    func didTapSend(with message: String) {
        
    }
}

struct TextInputView: View {
    let viewModel: TextInputViewModel
    @State private var message: String = ""
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $message
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            
            Button("Send") {
                viewModel.didTapSend(with: message)
            }.disabled(message.isEmpty)
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    TextInputView(viewModel: TextInputViewModel())
}
