//
//  ResponseLoaderIndicatorView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 9/8/25.
//

import SwiftUI

struct ResponseLoaderIndicatorView: View {
    @State private var animate = false

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0 ..< 3) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.secondary)
                    .scaleEffect(animate ? 1 : 0.6)
                    .opacity(animate ? 0.8 : 0.3)
                    .animation(
                        .easeInOut(duration: 0.8)
                            .repeatForever()
                            .delay(Double(index) * 0.15),
                        value: animate
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary.opacity(0.1))
        )
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ResponseLoaderIndicatorView()
    }
    .padding()
    .background(Color.secondary.opacity(0.05))
}
