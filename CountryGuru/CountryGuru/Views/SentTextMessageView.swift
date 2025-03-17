//
//  TextMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct SentTextMessageView: View {
    var body: some View {
        Text("Hello, World! This is a text message").padding()
        .background(Color.red)
        .cornerRadius(50)
    }
}

#Preview {
    SentTextMessageView()
}
