//
//  ReceiverTextMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 7/8/25.
//

import SwiftUI

struct ReceiverTextMessageView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding(12)
            .background(Color.blue)
    }
}

#Preview {
    ReceiverTextMessageView(text: "some text message")
}
