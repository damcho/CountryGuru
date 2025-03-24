//
//  main.swift
//  CountryGuruCLI
//
//  Created by Damian Modernell on 16/3/25.
//

import Foundation
import CountryGuruCore

let questionHandler = CountryGuruComposer.compose()

while let question = readLine() {
    Task {
        do {
            let reply = try await questionHandler.didAskRaw(question)
            switch reply {
            case .text(let response):
                print(response)
            case .multiple(let multipleResponses):
                multipleResponses.forEach { print($0) }
            default: break
            }
        } catch {
            print("There was an issue, please try again")
        }
    }
}

RunLoop.current.run()


