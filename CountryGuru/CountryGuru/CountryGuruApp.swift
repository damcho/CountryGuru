//
//  CountryGuruApp.swift
//  CountryGuru
//
//  Created by Damian Modernell on 17/3/25.
//

import CountryGuruCore
import SwiftUI

let countryFlagQuestion = (
    key: CountryFlagImageQuestion.question,
    factory: { countryName in CountryFlagImageQuestion(countryName: countryName) }
)

let inquiriesArray = [
    AnyInquiry(
        question: countryFlagQuestion.key,
        inquiryCreator: countryFlagQuestion.factory
    ),
    AnyInquiry(
        question: CountryGuruComposer.countryCapitalInquiry.key,
        inquiryCreator: CountryGuruComposer.countryCapitalInquiry.factory
    ),
    AnyInquiry(
        question: CountryGuruComposer.countryPrenomInquiry.key,
        inquiryCreator: CountryGuruComposer.countryPrenomInquiry.factory
    ),
    AnyInquiry(
        question: CountryGuruComposer.iso2CountryInquiry.key,
        inquiryCreator: CountryGuruComposer.iso2CountryInquiry.factory
    )
]

@main
struct CountryGuruApp: App {
    let questionLoader = CountryGuruComposer.compose(
        with: inquiriesArray
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
