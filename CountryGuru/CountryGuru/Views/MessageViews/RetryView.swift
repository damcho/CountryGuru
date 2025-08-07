//
//  RetryView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

struct RetryView: View {
    let onRetry: () -> Void

    var body: some View {
        Button {
            onRetry()
        } label: {
            VStack(alignment: .center, spacing: 4) {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 16))
                    Text(
                        "There was either a network error, or we could not find a proper answer to your question"
                    )
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                }
                Text("Tap to retry")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .underline()
            }
            .padding(12)
            .background(Color(red: 1.0, green: 0.95, blue: 0.95))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.red.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    RetryView(onRetry: {})
}
