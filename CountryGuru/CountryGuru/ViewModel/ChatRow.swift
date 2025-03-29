//
//  ChatRow.swift
//  CountryGuru
//
//  Created by Damian Modernell on 26/3/25.
//

import Foundation

struct ChatRow: Identifiable {
    var id = UUID()

    let sender: String?
    let receiver: InquiryViewModel?

    init(sender: String? = nil, receiver: InquiryViewModel? = nil) {
        self.sender = sender
        self.receiver = receiver
    }
}
