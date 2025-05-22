//
//  Item.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
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
