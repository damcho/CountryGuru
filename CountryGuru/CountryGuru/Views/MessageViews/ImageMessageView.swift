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
        AsyncImage(url: urlWithToken) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView()
            case .failure:
                RetryView {
                    reloadToken = UUID()
                }.frame(height: 150)
            @unknown default:
                EmptyView()
            }
        }
        .cornerRadius(20)
        .frame(maxWidth: 200, maxHeight: 200)
        .aspectRatio(contentMode: .fit)
    }

    private var urlWithToken: URL {
        var components = URLComponents(url: imageURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "cacheBust", value: reloadToken.uuidString)]
        return components.url!
    }
}

#Preview {
    ImageMessageView(imageURL: URL(string: "www.someurl.com")!)
}
