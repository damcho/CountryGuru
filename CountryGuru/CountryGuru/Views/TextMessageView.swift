//
//  TextMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct TextMessageView: View {
    var body: some View {
        HStack {
            Text("Hello, World! This is a text message").padding()
        }
        .background(Color.red)
        .cornerRadius(50)
    }
}

#Preview {
    TextMessageView()
}
