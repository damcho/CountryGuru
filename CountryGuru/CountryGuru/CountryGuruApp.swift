//
//  CountryGuruApp.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import SwiftUI
import CountryGuruCore

let countryFlagQuestion = (
    key: CountryFlagImageQuestion.question,
    factory: { countryName in  CountryFlagImageQuestion(countryName: countryName) }
)

@main
struct CountryGuruApp: App {
        
    let questionLoader = CountryGuruComposer.compose(
        with: [
            countryFlagQuestion.key: countryFlagQuestion.factory,
            CountryGuruComposer.countryCapitalInquiry.key: CountryGuruComposer.countryCapitalInquiry.factory,
            CountryGuruComposer.countryPrenomInquiry.key: CountryGuruComposer.countryPrenomInquiry.factory,
            CountryGuruComposer.iso2CountryInquiry.key: CountryGuruComposer.iso2CountryInquiry.factory
        ]
    )

    var body: some Scene {
        WindowGroup {
            InquiryChatScreen(
                viewModel: InquiryChatScreenViewModel(
                    inquiryViewModelFactory: {
                        InquiryViewModel { question in
                            try await questionLoader.didAskRaw(question)
                        }
                })
            )
        }
    }
}
