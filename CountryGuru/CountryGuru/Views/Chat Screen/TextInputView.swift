//
//  TextInputView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

struct TextInputView: View {
    let onSendAction: (String) -> Void
    @State private var message: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            TextField(
                "Ask about any country...",
                text: $message
            )
            .textFieldStyle(.plain)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
            .focused($isTextFieldFocused)
            .onSubmit {
                sendMessage()
            }

            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        message.isEmpty ? Color.gray.opacity(0.35) : Color.accentColor
                    )
                    .clipShape(Circle())
                    .shadow(
                        color: message.isEmpty ? Color.clear : Color.accentColor.opacity(0.25),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            }
            .disabled(message.isEmpty)
            .scaleEffect(message.isEmpty ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: message.isEmpty)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(.bar)
    }

    private func sendMessage() {
        guard !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        onSendAction(message)
        message = ""
        isTextFieldFocused = false
    }
}

#Preview {
    TextInputView(onSendAction: { _ in })
        .background(Color.secondary.opacity(0.05))
}
