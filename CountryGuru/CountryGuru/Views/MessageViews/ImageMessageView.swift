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
                    .resizable()
                    .scaledToFit()
            case .empty:
                ProgressView()
            case .failure:
                Image(systemName: "xmark.octagon")
            @unknown default:
                EmptyView()
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
