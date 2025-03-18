//
//  TextInputView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct TextInputView: View {
    var body: some View {
        HStack {
            TextField(
                "User name",
                text: .constant("")
            )
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            
            Button("Send") {
                
            }
        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    TextInputView()
}
