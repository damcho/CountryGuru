//
//  ImageMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ImageMessageView: View {
    let imageURL: URL
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .ignoresSafeArea()
                    .scaledToFit()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
            case .empty:
                Color.blue
            @unknown default: Color.blue
            }
        }
        .cornerRadius(20)
        .frame(maxWidth: 200, maxHeight: 200)
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ImageMessageView(imageURL: URL(string: "www.someurl.com")!)
}
