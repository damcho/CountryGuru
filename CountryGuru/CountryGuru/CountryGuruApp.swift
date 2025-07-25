//
//  CountryGuruApp.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import CountryGuruCore
import SwiftUI

let countryFlagQuestion =
    AnyInquiry(
        question: CountryFlagImageQuestion.question,
        inquiryCreator: { countryName in CountryFlagImageQuestion(countryName: countryName) }
    )

let supportedInquiriesArray = [
    CountryGuruComposer.countryCapitalInquiry,
    CountryGuruComposer.countryPrenomInquiry,
    countryFlagQuestion,
    CountryGuruComposer.iso2CountryInquiry
]

@main
struct CountryGuruApp: App {
    let questionLoader = CountryGuruComposer.compose(
        with: supportedInquiriesArray
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                InquiryChatScreen(
                    viewModel: InquiryChatScreenViewModel(
                        inquiryResolverFactory: {
                            InquiryResponseViewModel { question in
                                try await questionLoader.didAskRaw(question)
                            }
                        }
                    )
                ).navigationTitle("Country Guru")
            }
        }
    }
}
