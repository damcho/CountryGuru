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
            Spacer()
            TextField(
                "User name",
                text: .constant("")
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .padding()
        }
        .padding()
    }
}

#Preview {
    InquiryChatScreen()
}
