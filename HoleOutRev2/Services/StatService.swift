//
//  StatService.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData

class StatService: ObservableObject {
    private let logger = Logger()
    
    private let roundService: RoundService
    private let courseService = CourseService()
    
    init(modelContext: ModelContext) {
        self.roundService = RoundService(modelContext: modelContext)
    }
    
    // MARK: - Scoring Averages

    // Totals
    
    func averageTotalScoreByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedScores = Double(roundsAtCourse.reduce(0) { $0 + $1.totalScore })
        let numRounds = Double(roundsAtCourse.count)
        return summedScores / numRounds
    }
    
    func averageScoreOverall() -> Double {
        let completedRounds = roundService.getAllRounds().filter { $0.isComplete }
        guard completedRounds.isEmpty else { return 0 }
        let summedScores = Double(completedRounds.reduce(0) { $0 + $1.totalScore })
        let numRounds = Double(completedRounds.count)
        return summedScores / numRounds
    }
    
    func averageScoreByHole(holeNumber: Int, courseId: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: courseId)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].isScored
        }
        guard !validRounds.isEmpty else { return 0 }
        let summedScoreAtHole = Double(validRounds.reduce(0) { $0 + $1.sortedHoles[holeNumber - 1].score } )
        return summedScoreAtHole / Double(validRounds.count)
    }
    
    // Front 9
    
    func averageFrontScoreByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedFrontScores = Double(roundsAtCourse.reduce(0) { $0 + $1.frontScore })
        let numRounds = Double(roundsAtCourse.count)
        return summedFrontScores / numRounds
    }
    
    func averageFrontScoreOverall() -> Double {
        let completedRounds = roundService.getAllRounds().filter { $0.isComplete }
        guard !completedRounds.isEmpty else { return 0 }
        let summedScores = Double(completedRounds.prefix(9).reduce(0) { $0 + $1.totalScore })
        let numRounds = Double(completedRounds.count)
        return summedScores / numRounds
    }
    
    // Back 9
    
    func averageBackScoreByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedBackScores = Double(roundsAtCourse.reduce(0) { $0 + $1.backScore })
        let numRounds = Double(roundsAtCourse.count)
        return summedBackScores / numRounds
    }
    
    func averageBackScoreOverall() -> Double {
        let completedRounds = roundService.getAllRounds().filter { $0.isComplete }
        guard !completedRounds.isEmpty else { return 0 }
        let summedScores = Double(completedRounds.suffix(9).reduce(0) { $0 + $1.totalScore })
        let numRounds = Double(completedRounds.count)
        return summedScores / numRounds
    }
    
    // MARK: - Putting Averages
    
    func averagePuttsPerHoleByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedPutts = Double(roundsAtCourse.reduce(0) { $0 + $1.totalPutts })
        let totalHolesScored = Double(roundsAtCourse.reduce(0) { $0 + $1.numHolesScored })
        return summedPutts / totalHolesScored
    }
    
    func averagePuttsPerRound() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0 }
        let summedPutts = Double(rounds.reduce(0) { $0 + $1.totalPutts })
        let totalRounds = Double(rounds.count)
        return summedPutts / totalRounds
    }
    
    func averagePuttsByHole(holeNumber: Int, courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let summedPuttsAtHole = Double(validRounds.reduce(0) { $0 + $1.sortedHoles[holeNumber - 1].numPutts } )
        return summedPuttsAtHole / Double(validRounds.count)
    }
    
    
    // MARK: - Sand Shot Averages
    
    func averageSandShotsPerHoleByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedSandShots = Double(roundsAtCourse.reduce(0) { $0 + $1.totalSandShots })
        let totalHolesScored = Double(roundsAtCourse.reduce(0) { $0 + $1.numHolesScored })
        return summedSandShots / totalHolesScored
    }
    
    func averageSandShotsPerRound() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0 }
        let summedSandShots = Double(rounds.reduce(0) { $0 + $1.totalSandShots })
        let totalHolesScored = Double(rounds.reduce(0) { $0 + $1.numHolesScored })
        return summedSandShots / totalHolesScored
    }
    
    func averageSandShotsByHole(holeNumber: Int, courseId: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: courseId)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let summedSandShotsAtHole = Double(validRounds.reduce(0) { $0 + $1.sortedHoles[holeNumber - 1].sandShots } )
        return summedSandShotsAtHole / Double(validRounds.count)
    }
    
    // MARK: - Penalty Averages
    
    func averagePenaltiesPerHoleByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedPenalties = Double(roundsAtCourse.reduce(0) { $0 + $1.totalPenalties })
        let totalHolesScored = Double(roundsAtCourse.reduce(0) { $0 + $1.numHolesScored })
        return summedPenalties / totalHolesScored
    }
    
    func averagePenaltiesPerRound() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0 }
        let summedPenalties = Double(rounds.reduce(0) { $0 + $1.totalPenalties })
        let totalHolesScored = Double(rounds.reduce(0) { $0 + $1.numHolesScored })
        return summedPenalties / totalHolesScored
    }
    
    func averagePenaltiesByHole(holeNumber: Int, courseId: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: courseId)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let summedPenaltiesAtHole = Double(validRounds.reduce(0) { $0 + $1.sortedHoles[holeNumber - 1].penalties } )
        return summedPenaltiesAtHole / Double(validRounds.count)
    }
    
    // MARK: - GIR Stats
    
    func totalGirPercentageByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedGirPercentage = roundsAtCourse.reduce(0) { $0 + $1.totalGirPercentage }
        return summedGirPercentage / Double(roundsAtCourse.count)
    }
    
    func frontGirPercentageByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedGirPercentage = roundsAtCourse.reduce(0) { $0 + $1.frontGirPercentage }
        return summedGirPercentage / Double(roundsAtCourse.count)
    }
    
    func backGirPercentageByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedGirPercentage = roundsAtCourse.reduce(0) { $0 + $1.frontGirPercentage }
        return summedGirPercentage / Double(roundsAtCourse.count)
    }
    
    func overallGirPercentage() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0.0 }
        let summedGirPercentage = rounds.reduce(0) { $0 + $1.totalGirPercentage }
        return summedGirPercentage / Double(rounds.count)
    }
    
    func girPercentageByHole(courseId id: Int, holeNumber: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let numGirs = validRounds.filter { $0.sortedHoles[holeNumber - 1].greenInRegulation }.count
        return Double(numGirs) / Double(validRounds.count)
    }
    
    // MARK: - Sand Saves
    
    func overallSandSavePercentage() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0.0 }
        let summedSandSavePercentage = rounds.reduce(0) { $0 + $1.sandSavePercentage }
        return summedSandSavePercentage / Double(rounds.count)
    }
    
    func totalSandSavePercentageByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        let summedSandSavePercentage = roundsAtCourse.reduce(0) { $0 + $1.sandSavePercentage }
        return summedSandSavePercentage / Double(roundsAtCourse.count)
    }
    
    func SandSavePercentageByHole(courseId id: Int, holeNumber: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let numSandSaves = validRounds.filter { $0.sortedHoles[holeNumber - 1].sandSave }.count
        return Double(numSandSaves) / Double(validRounds.count)
    }
    
    // MARK: - Up & Downs
    
    func overallUpAndDownPercentage() -> Double {
        let rounds = roundService.getAllRounds()
        guard !rounds.isEmpty else { return 0.0 }
        let summedUpAndDowns = rounds.reduce(0) { $0 + $1.upAndDownPercentage }
        return summedUpAndDowns / Double(rounds.count)
    }
    
    func upAndDownPercentageByCourse(courseId id: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0.0 }
        let summedUpAndDowns = roundsAtCourse.reduce(0) { $0 + $1.upAndDownPercentage }
        return summedUpAndDowns / Double(roundsAtCourse.count)
    }
    
    func upAndDownPercentageByHole(courseId id: Int, holeNumber: Int) -> Double {
        let roundsAtCourse = roundService.getRoundsByCourseId(id: id)
        guard !roundsAtCourse.isEmpty else { return 0 }
        // Ensure we only calculate for rounds that have scored the given hole
        let validRounds = roundsAtCourse.filter { round in
            round.sortedHoles.count > holeNumber - 1 && round.sortedHoles[holeNumber - 1].advancedTracking
        }
        guard !validRounds.isEmpty else { return 0 }
        let numUpAndDowns = validRounds.filter { $0.sortedHoles[holeNumber - 1].upAndDown }.count
        return Double(numUpAndDowns) / Double(validRounds.count)
    }
     
    // TBI
    func handicapIndex() -> Double {
        return 0.0
    }
}
