//
//  ChatRow.swift
//  CountryGuru
//
//  Created by Damian Modernell on 26/3/25.
//

import Foundation
import SwiftUI

struct ChatRow: Identifiable {
    var id = UUID()

    let sender: AnyView?
    let receiver: AnyView?

    init(sender: AnyView? = nil, receiver: AnyView? = nil) {
        self.sender = sender
        self.receiver = receiver
    }
}
