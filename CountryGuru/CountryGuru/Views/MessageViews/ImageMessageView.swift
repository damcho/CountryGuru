//
//  ImageMessageView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 25/3/25.
//

import SwiftUI

struct ImageMessageView: View {
    let imageURL: URL
    @State private var imageLoaded = false
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFit()
                    .opacity(imageLoaded ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            imageLoaded = true
                        }
                    }
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
