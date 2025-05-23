//
//  Yardages.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData

struct Yardages: Codable {
    var blues: Int
    var whites: Int
    var reds: Int
    
    init(b blues: Int, w whites: Int, r reds: Int) {
        self.blues = blues
        self.whites = whites
        self.reds = reds
    }
}
