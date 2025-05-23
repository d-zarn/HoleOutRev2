//
//  Round.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData

@Model
class RoundModel {
    var roundId: UUID
    var courseId: UUID
    var date: Date
    var holesPlayed: Int
    var startTime: Date
    var endTime: Date?
    @Relationship(deleteRule: .cascade) var holes: [HoleModel]
    
    init(courseId: UUID) {
        self.roundId = UUID()
        self.courseId = courseId
        self.date = Date()
        self.holesPlayed = 0
        self.startTime = Date()
        self.holes = []
    }
}
