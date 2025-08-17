//
//  ImageMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ImageMessageView: View {
    let imageURL: URL
    @State private var reloadToken = UUID()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: urlWithToken) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .transition(.opacity.combined(with: .scale))
                case .empty:
                    HStack {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Loading image...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(height: 150)
                case .failure:
                    VStack(spacing: 12) {
                        Image(systemName: "photo.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Failed to load image")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            reloadToken = UUID()
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                    .frame(height: 150)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(16)
            .frame(maxWidth: 250, maxHeight: 250)
            .aspectRatio(contentMode: .fit)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.secondary.opacity(0.1))
            )
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal, 4)
    }

    private var urlWithToken: URL {
        var components = URLComponents(url: imageURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "cacheBust", value: reloadToken.uuidString)]
        return components.url!
    }
}

#Preview {
    VStack(spacing: 16) {
        ImageMessageView(imageURL: URL(string: "https://example.com/flag.png")!)
    }
    .padding()
    .background(Color.secondary.opacity(0.05))
}
