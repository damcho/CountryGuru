//
//  RetryView.swift
//  CountryGuru
//
//  Created by Damian Modernell on 27/3/25.
//

import SwiftUI

struct RetryView: View {
    let onRetry: () -> Void
    
    var body: some View {
        Button {
            onRetry()
        } label: {
            Text("Network error, \n tap to retry")
            Image(systemName: "arrow.clockwise.circle.fill").foregroundStyle(.red)
        }.foregroundStyle(.red)
    }
}

#Preview {
    RetryView(onRetry: {})
}
