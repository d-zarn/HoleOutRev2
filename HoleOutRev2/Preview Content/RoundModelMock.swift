//
//  RoundModelMock.swift
//  HoleOutRev2
//
//  Created by [Your Name] on [Current Date].
//

import Foundation
import SwiftData

/// Provides mock RoundModel instances for previews and testing
enum RoundModelMock {
    
    /// Creates a mock HoleModel for testing
    private static func createMockHole(
        number: Int,
        par: Int,
        score: Int? = nil,
        putts: Int = 0,
        sandShots: Int = 0,
        penalties: Int = 0,
        gir: Bool = false,
        sandSave: Bool = false,
        upAndDown: Bool = false,
        holeType: HoleType = .straight,
        advancedTracking: Bool = true
    ) -> HoleModel {
        // Generate realistic yardages based on par
        let blueYardage = par == 3 ? Int.random(in: 150...220) :
                          par == 4 ? Int.random(in: 350...450) :
                                     Int.random(in: 500...600)
        
        let whiteYardage = blueYardage - Int.random(in: 15...35)
        let redYardage = whiteYardage - Int.random(in: 25...45)
        
        // Create the hole
        let hole = HoleModel(
            id: number,
            par: par,
            blues: blueYardage,
            whites: whiteYardage,
            reds: redYardage,
            holeType: holeType
        )
        
        // Only set score if provided (to simulate incomplete holes)
        if let score = score {
            hole.score = score
            hole.isScored = true
        }
        
        hole.numPutts = putts
        hole.sandShots = sandShots
        hole.penalties = penalties
        hole.greenInRegulation = gir
        hole.sandSave = sandSave
        hole.upAndDown = upAndDown
        hole.advancedTracking = advancedTracking
        
        return hole
    }
    
    /// Creates a complete mock round with 18 holes
    static func completeRound() -> RoundModel {
        let courseId = CourseRepository.shared.getAllCourses()[0].id
        let round = RoundModel(courseId: courseId)
        
        // Set round dates
        round.date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        round.startTime = Calendar.current.date(byAdding: .hour, value: -5, to: round.date) ?? round.date
        round.endTime = Calendar.current.date(byAdding: .hour, value: -1, to: round.date) ?? round.date
        round.holesPlayed = 18
        
        // Add 18 holes with varying scores and stats
        let parSequence = [4, 5, 3, 4, 4, 5, 3, 4, 4, 4, 3, 5, 4, 4, 3, 5, 4, 4]
        let holeTypes: [HoleType] = [.straight, .dogLeft, .dogRight]
        
        for i in 1...18 {
            let par = parSequence[i-1]
            let holeType = holeTypes[i % 3]
            let sandShots = Bool.random() ? Int.random(in: 0...2) : 0
            
            let hole = createMockHole(
                number: i,
                par: par,
                score: par + Int.random(in: -2...2),
                putts: Int.random(in: 1...3),
                sandShots: sandShots,
                penalties: i % 7 == 0 ? 1 : 0,  // Occasional penalty
                gir: Bool.random(),
                sandSave: sandShots > 0 && Bool.random(),
                upAndDown: Bool.random(),
                holeType: holeType
            )
            
            hole.round = round
            round.holes.append(hole)
        }
        
        return round
    }
    
    /// Creates an in-progress round (9 holes completed)
    static func inProgressRound() -> RoundModel {
        let courseId = CourseRepository.shared.getAllCourses()[0].id
        let round = RoundModel(courseId: courseId)
        
        // Set round dates for today
        round.date = Date()
        round.startTime = Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date()
        round.holesPlayed = 9
        round.currentHoleIndex = 9  // On the 10th hole
        
        // Add 18 holes but only score the first 9
        let parSequence = [4, 5, 3, 4, 4, 5, 3, 4, 4, 4, 3, 5, 4, 4, 3, 5, 4, 4]
        let holeTypes: [HoleType] = [.straight, .dogLeft, .dogRight]
        
        for i in 1...18 {
            let par = parSequence[i-1]
            let holeType = holeTypes[i % 3]
            let isCompleted = i <= 9
            let score = isCompleted ? par + Int.random(in: -1...2) : nil
            let putts = isCompleted ? Int.random(in: 1...3) : 0
            let sandShots = isCompleted && Bool.random() ? Int.random(in: 0...2) : 0
            
            let hole = createMockHole(
                number: i,
                par: par,
                score: score,
                putts: putts,
                sandShots: sandShots,
                penalties: isCompleted && i % 7 == 0 ? 1 : 0,
                gir: isCompleted && Bool.random(),
                sandSave: isCompleted && sandShots > 0 && Bool.random(),
                upAndDown: isCompleted && i % 4 == 0,
                holeType: holeType
            )
            
            hole.round = round
            round.holes.append(hole)
        }
        
        return round
    }
    
    /// Creates a round with specific stats for testing
    static func specialStatsRound() -> RoundModel {
        let courseId = 0001
        let round = RoundModel(courseId: courseId)
        
        // Set round dates
        round.date = Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date()
        round.startTime = Calendar.current.date(byAdding: .hour, value: -4, to: round.date) ?? round.date
        round.endTime = Calendar.current.date(byAdding: .hour, value: -1, to: round.date) ?? round.date
        round.holesPlayed = 18
        
        // Define specific stats for testing edge cases
        let parSequence = [4, 5, 3, 4, 4, 5, 3, 4, 4, 4, 3, 5, 4, 4, 3, 5, 4, 4]
        let scoreSequence = [3, 5, 4, 4, 5, 7, 2, 5, 3, 4, 2, 6, 4, 5, 4, 4, 3, 5] // -1 under par
        let puttSequence = [1, 2, 2, 2, 3, 2, 1, 2, 1, 2, 1, 3, 2, 2, 2, 1, 1, 2] // 32 total putts
        let girSequence = [true, false, false, true, false, false, true, false, true, true, true, false, true, false, false, true, true, false] // 9 GIRs
        let sandShotSequence = [0, 1, 0, 0, 2, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1]
        let holeTypeSequence: [HoleType] = [
            .straight, .dogLeft, .straight, .dogRight, .straight,
            .dogLeft, .straight, .dogRight, .straight, .dogLeft,
            .straight, .dogRight, .dogLeft, .straight, .dogRight,
            .straight, .dogLeft, .straight
        ]
        
        for i in 1...18 {
            let sandShots = sandShotSequence[i-1]
            
            let hole = createMockHole(
                number: i,
                par: parSequence[i-1],
                score: scoreSequence[i-1],
                putts: puttSequence[i-1],
                sandShots: sandShots,
                penalties: i == 6 ? 2 : 0,
                gir: girSequence[i-1],
                sandSave: sandShots > 0 && (i == 5 || i == 12),
                upAndDown: i == 2 || i == 8 || i == 15,
                holeType: holeTypeSequence[i-1]
            )
            
            hole.round = round
            round.holes.append(hole)
        }
        
        return round
    }
    
    /// Creates an array of mock rounds for testing lists
    static func mockRounds(count: Int = 5) -> [RoundModel] {
        var rounds: [RoundModel] = []
        
        // Add our special rounds
        rounds.append(completeRound())
        rounds.append(inProgressRound())
        rounds.append(specialStatsRound())
        
        // Add additional random rounds if needed
        for i in 0..<(count - 3) {
            let round = completeRound()
            round.date = Calendar.current.date(byAdding: .day, value: -(i+2), to: Date()) ?? Date()
            rounds.append(round)
        }
        
        return rounds
    }
}

// MARK: - SwiftUI Preview Extensions
#if DEBUG
extension RoundModel {
    static var mock: RoundModel {
        RoundModelMock.completeRound()
    }
    
    static var inProgress: RoundModel {
        RoundModelMock.inProgressRound()
    }
}
#endif
