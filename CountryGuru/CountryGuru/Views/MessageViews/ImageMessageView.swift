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
        AsyncImage(url: imageURL)
            .cornerRadius(20)
            .frame(maxWidth: 200, maxHeight: 200)
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ImageMessageView(imageURL: URL(string: "www.someurl.com")!)
}
