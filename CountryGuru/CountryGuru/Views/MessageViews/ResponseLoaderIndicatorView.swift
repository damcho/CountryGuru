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
        HStack(spacing: 4) {
            ForEach(0 ..< 3) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.gray)
                    .scaleEffect(animate ? 1 : 0.5)
                    .opacity(animate ? 1 : 0.3)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: animate
                    )
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    ResponseLoaderIndicatorView()
}
