//
//  ContentView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct InquiryChatScreen: View {
    var body: some View {
        VStack {
            ScrollView {
                QuestionAnswerView()
            }
            TextInputView(onSendAction: {_ in })
        }
        .padding()
    }
}

#Preview {
    InquiryChatScreen()
}
