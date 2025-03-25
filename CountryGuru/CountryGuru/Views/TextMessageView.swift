//
//  TextMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct TextMessageView: View {
    let message: String
    var body: some View {
        Text(message)
    }
}

#Preview {
    TextMessageView(message: "hello world")}
