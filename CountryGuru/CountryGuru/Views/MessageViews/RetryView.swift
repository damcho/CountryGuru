//
//  RetryView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

struct RetryView: View {
    var body: some View {
        Button {
            print("tapped")
        } label: {
            Text("Network error, \n tap to retry")
            Image(systemName: "arrow.clockwise.circle.fill").foregroundStyle(.red)
        }.foregroundStyle(.red)
    }
}

#Preview {
    RetryView()
}
