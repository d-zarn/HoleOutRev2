//
//  RoundModel.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-26.
//


import Foundation
import SwiftData

@Model
class RoundModel {
    var roundId: UUID
    var courseId: Int
    var date: Date
    var holesPlayed: Int
    var startTime: Date
    var endTime: Date?
    var isComplete: Bool = false
    
    @Relationship(deleteRule: .cascade) var holes: [HoleModel]
    
    @Transient var currentHoleIndex: Int = 0
    
    init(courseId: Int) {
        self.roundId = UUID()
        self.courseId = courseId
        self.date = Date()
        self.holesPlayed = 0
        self.startTime = Date()
        self.holes = []
        self.currentHoleIndex = 0
    }
    
    var numHolesScored: Int {
        return holes.filter { $0.isScored }.count
    }
    
    var sortedHoles: [HoleModel] {
        return holes.sorted { $0.holeNumber < $1.holeNumber }
    }
    
    var duration: TimeInterval? {
        guard let endTime = endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }
    
    var formattedDuration: String {
        guard let endTime = endTime else { return "In Progress" }
        let roundDuration = endTime.timeIntervalSince(startTime)
        
        let hours = Int(roundDuration) / 3600
        let minutes = (Int(roundDuration) % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: - Navigation Help
    
    var currentHole: HoleModel? {
        guard !sortedHoles.isEmpty, currentHoleIndex < sortedHoles.count else { return nil }
        return sortedHoles[currentHoleIndex]
    }
    
    var isFirstHole: Bool {
        return currentHoleIndex == 0
    }
    
    var isLastHole: Bool {
        return currentHoleIndex == sortedHoles.count - 1
    }
    
    func moveToNextHole() {
        if !isLastHole {
            currentHoleIndex += 1
            if currentHoleIndex > holesPlayed {
                holesPlayed = currentHoleIndex
            }
        }
    }
    
    func moveToPreviousHole() {
        if !isFirstHole {
            currentHoleIndex -= 1
        }
    }
    
    // MARK: - Round Stat Summaries
    
    var totalScore: Int {
        let completedHoles = sortedHoles.filter { $0.isScored }
        guard completedHoles.count > 0 else { return 0 }
        return completedHoles.reduce(0) { $0 + $1.score }
    }
    
    var frontScore: Int {
        return sortedHoles.prefix(9).filter { $0.isScored }.reduce(0) { $0 + $1.score }
    }
    
    var backScore: Int {
        return sortedHoles.suffix(9).filter { $0.isScored }.reduce(0) { $0 + $1.score }
    }
    
    var totalPutts: Int {
        return sortedHoles.reduce(0) { $0 +  $1.numPutts }
    }
    
    var frontPutts: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 +  $1.numPutts }
    }
    
    var backPutts: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 +  $1.numPutts }
    }
    
    var totalSandShots: Int {
        return sortedHoles.reduce(0) { $0 +  $1.sandShots }
    }
    
    var frontSandShots: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 +  $1.sandShots }
    }
    
    var backSandShots: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 +  $1.sandShots }
    }
    
    var totalGreensInRegulation: Int {
        return sortedHoles.filter { $0.greenInRegulation }.count
    }
    
    var frontGreensInRegulation: Int {
        return sortedHoles.prefix(9).filter { $0.greenInRegulation }.count
    }
    
    var backGreensInRegulation: Int {
        return sortedHoles.suffix(9).filter { $0.greenInRegulation }.count
    }
    
    var totalSandSaves: Int {
        return sortedHoles.filter { $0.sandSave }.count
    }
    
    var frontSandSaves: Int {
        return sortedHoles.prefix(9).filter { $0.sandSave }.count
    }
    
    var backSandSaves: Int {
        return sortedHoles.suffix(9).filter { $0.sandSave }.count
    }
    
    var totalUpAndDowns: Int {
        return sortedHoles.filter { $0.upAndDown }.count
    }
    
    var frontUpAndDowns: Int {
        return sortedHoles.prefix(9).filter { $0.upAndDown }.count
    }
    
    var backUpAndDowns: Int {
        return sortedHoles.suffix(9).filter { $0.upAndDown }.count
    }
    
    var totalPenalties: Int {
        return sortedHoles.reduce(0) { $0 + $1.penalties }
    }
    
    var frontPenalties: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 + $1.penalties }
    }
    
    var backPenalties: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 + $1.penalties }
    }
    
    var totalGirPercentage: Double {
        let completedHoles = sortedHoles.filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalGreensInRegulation) / Double(completedHoles) * 100
    }
    
    var frontGirPercentage: Double {
        let completedHoles = sortedHoles.prefix(9).filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(frontGreensInRegulation) / Double(completedHoles) * 100
    }
    
    var backGirPercentage: Double {
        let completedHoles = sortedHoles.suffix(9).filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(backGreensInRegulation) / Double(completedHoles) * 100
    }
    
    var totalAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalPutts) / Double(completedHoles)
    }
    
    var frontAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.prefix(9).filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(frontPutts) / Double(completedHoles)
    }
    
    var backAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.suffix(9).filter { $0.isScored }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(backPutts) / Double(completedHoles)
    }
    
}
