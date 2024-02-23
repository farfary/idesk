//
//  Item.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-09.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
