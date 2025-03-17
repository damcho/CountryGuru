//
//  QuestionAnswerView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct QuestionAnswerView: View {
    var body: some View {
        VStack {
            TextMessageView().senderMessageAlignment()
            TextMessageView().receiverMessageAlignment()
        }
    }
}

#Preview {
    QuestionAnswerView()
}
