//
//  OpenAIInterpreterIntegrationTests.swift
//  CountryGuruCoreIntegrationTests
//
//  Created by Damian Modernell on 17/3/25.
//

@testable import CountryGuruCore
import Foundation
import Testing

struct OpenAIInterpreterIntegrationTests {
    // MARK: - Test Configuration

    private let httpClient = URLSessionHTTPClient(session: .shared)

    private func makeSUT() -> OpenAIInterpreter {
        OpenAIInterpreter(
            apiKey: CountryGuruComposer.openAIAPIKey,
            inquiries: CountryGuruComposer.inquiriesArray,
            httpClient: httpClient
        )
    }

    // MARK: - Capital Question Tests

    @Test
    func capital_question_creates_country_capital_inquiry() async throws {
        let question = "What is the capital of Argentina?"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryCapitalQuestion)
        #expect((inquiry as? CountryCapitalQuestion)?.countryName == "Argentina")
    }

    @Test
    func capital_question_with_different_phrasing() async throws {
        let question = "Show me the capital of Brazil"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryCapitalQuestion)
        #expect((inquiry as? CountryCapitalQuestion)?.countryName == "Brazil")
    }

    // MARK: - Flag Question Tests

    @Test
    func flag_question_creates_country_flag_inquiry() async throws {
        let question = "What's the flag of France?"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryFlagQuestion)
        #expect((inquiry as? CountryFlagQuestion)?.countryName == "France")
    }

    @Test
    func flag_question_with_different_phrasing() async throws {
        let question = "Display the flag for Germany"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryFlagQuestion)
        #expect((inquiry as? CountryFlagQuestion)?.countryName == "Germany")
    }

    // MARK: - ISO Code Question Tests

    @Test
    func iso_question_creates_iso_alpha2_inquiry() async throws {
        let question = "What is the ISO code of Japan?"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is ISOalpha2CountryQuestion)
        #expect((inquiry as? ISOalpha2CountryQuestion)?.countryName == "Japan")
    }

    @Test
    func iso_question_with_different_phrasing() async throws {
        let question = "Give me the alpha-2 code for Australia"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is ISOalpha2CountryQuestion)
        #expect((inquiry as? ISOalpha2CountryQuestion)?.countryName == "Australia")
    }

    // MARK: - Startswith Question Tests

    @Test
    func startswith_question_creates_country_prenom_inquiry() async throws {
        let question = "Which countries start with BR?"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryPrenomQuestion)
        #expect((inquiry as? CountryPrenomQuestion)?.countryPrenom == "BR")
    }

    @Test
    func startswith_question_with_different_phrasing() async throws {
        let question = "Show countries that start with A"
        let inquiry = try await makeSUT().inquiry(from: question)

        #expect(inquiry is CountryPrenomQuestion)
        #expect((inquiry as? CountryPrenomQuestion)?.countryPrenom == "A")
    }

    // MARK: - Edge Cases and Error Handling

    @Test
    func handles_unsupported_questions() async throws {
        let question = "What's the weather like in Paris?"

        await #expect(throws: InquiryInterpreterError.notSupported) {
            _ = try await makeSUT().inquiry(from: question)
        }
    }

    @Test
    func handles_malformed_questions() async throws {
        let question = "capital of"

        await #expect(throws: InquiryInterpreterError.notSupported) {
            _ = try await makeSUT().inquiry(from: question)
        }
    }

    @Test
    func handles_empty_questions() async throws {
        let question = ""

        await #expect(throws: InquiryInterpreterError.notSupported) {
            _ = try await makeSUT().inquiry(from: question)
        }
    }

    // MARK: - Performance Tests

    @Test
    func reasonable_response_time() async throws {
        let question = "What is the capital of Canada?"
        let startTime = Date()

        _ = try await makeSUT().inquiry(from: question)

        let responseTime = Date().timeIntervalSince(startTime)
        #expect(responseTime < 10.0, "Response time should be under 10 seconds")
    }
}
