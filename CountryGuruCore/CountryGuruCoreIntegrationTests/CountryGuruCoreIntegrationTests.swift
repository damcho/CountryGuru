//
//  CountryGuruCoreIntegrationTests.swift
//  CountryGuruCoreIntegrationTests
//
//  Created by Damian Modernell on 31/3/25.
//

import CountryGuruCore
import Testing

struct CountryGuruCoreIntegrationTests {
    @Test
    func answers_country_capital_question_successfully() async throws {
        let sut = CountryGuruComposer.compose()

        let response = try await sut.didAskRaw("What is the capital of Argentina?")

        #expect(response == .text("Buenos Aires"))
    }

    @Test
    func answers_country_flag_question_successfully() async throws {
        let sut = CountryGuruComposer.compose()

        let response = try await sut.didAskRaw("What is the flag of Argentina?")

        #expect(response == .text("🇦🇷"))
    }

    @Test
    func answers_country_prefix_question_successfully() async throws {
        let sut = CountryGuruComposer.compose()

        let response = try await sut.didAskRaw("What countries start with Argen?")

        #expect(response == .multiple(["Argentina"]))
    }

    @Test
    func answers_alpha_2_question_successfully() async throws {
        let sut = CountryGuruComposer.compose()

        let response = try await sut.didAskRaw("What is the ISO alpha-2 country code for Argentina?")

        #expect(response == .text("AR"))
    }
}
