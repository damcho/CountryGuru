//
//  CountryGuruApp.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI

@main
struct CountryGuruApp: App {
    var body: some Scene {
        WindowGroup {
            InquiryChatScreen(
                viewModel: InquiryChatScreenViewModel(
                    inquiryViewModelFactory: {
                        InquiryViewModel { _ in .text(" a response")}
                })
            )
        }
    }
}
