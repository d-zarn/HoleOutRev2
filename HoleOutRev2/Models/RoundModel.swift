/**
 Used to model a round and contains details and calculated statistics for the round
 */


import Foundation
import SwiftData

@Model
class RoundModel {
    /// Round Identifier
    var roundId: UUID
    
    /// Id for associated course
    var courseId: Int
    
    /// date played
    var date: Date
    
    /// number of holes scored
    var holesPlayed: Int
    
    /// time the round started
    var startTime: Date
    
    /// time the round ended
    var endTime: Date?
    
    /// whether or not all 18 holes were scored
    var isComplete: Bool = false
    
    var teesPlayed: TeeModel
    
    /// the holes of the associated course
    @Relationship(deleteRule: .cascade) var holes: [HoleModel]
    
    /// The current hole being viewed. Used for scoring navigation
    @Transient var currentHoleIndex: Int = 0
    
    init(courseId: Int, teesPlayed: TeeModel) {
        self.roundId = UUID()
        self.courseId = courseId
        self.date = Date()
        self.holesPlayed = 0
        self.startTime = Date()
        self.holes = []
        self.teesPlayed = teesPlayed
        self.currentHoleIndex = 0
    }
    
    /// the number of holes with a score
    var numHolesScored: Int {
        return holes.filter { $0.isScored }.count
    }
    
    /// holes sorted by number
    var sortedHoles: [HoleModel] {
        return holes.sorted { $0.holeNumber < $1.holeNumber }
    }
    
    /// the length of the round from start time to end time
    var duration: TimeInterval? {
        guard let endTime = endTime else { return nil }
        return endTime.timeIntervalSince(startTime)
    }
    
    /// duration formatted to string
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
    
    /// date formatted to string
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: - Navigation Help
    
    /// the current hole being viewed
    var currentHole: HoleModel? {
        guard !sortedHoles.isEmpty, currentHoleIndex < sortedHoles.count else { return nil }
        return sortedHoles[currentHoleIndex]
    }
    
    /// true if the first hole is being viewed
    var isFirstHole: Bool {
        return currentHoleIndex == 0
    }
    
    /// true if the last hole is being viewed
    var isLastHole: Bool {
        return currentHoleIndex == sortedHoles.count - 1
    }
    
    /// increases the currentHoleIndex if not at the last hole
    func moveToNextHole() {
        if !isLastHole {
            currentHoleIndex += 1
            if currentHoleIndex > holesPlayed {
                holesPlayed = currentHoleIndex
            }
        }
    }
    
    /// decreases the currenHoleIndex if not the first hole
    func moveToPreviousHole() {
        if !isFirstHole {
            currentHoleIndex -= 1
        }
    }
    
    // MARK: - Round Stat Summaries
    
    /// the summed score of all scored holes
    var totalScore: Int {
        let completedHoles = sortedHoles.filter { $0.isScored }
        guard completedHoles.count > 0 else { return 0 }
        return completedHoles.reduce(0) { $0 + $1.score }
    }
    
    /// the summed score for the scored holes in the front 9
    var frontScore: Int {
        return sortedHoles.prefix(9).filter { $0.isScored }.reduce(0) { $0 + $1.score }
    }
    
    /// the summed score for the scored holes in the back 9
    var backScore: Int {
        return sortedHoles.suffix(9).filter { $0.isScored }.reduce(0) { $0 + $1.score }
    }
    
    /// the summed par for all scored holes
    var totalParForPlayedHoles: Int {
        return sortedHoles.filter { $0.isScored }.reduce(0) { $0 + $1.par }
    }
    
    /// the summed par for all scored holes in the front 9
    var frontParForPlayedHoles: Int {
        return sortedHoles.prefix(9).filter { $0.isScored }.reduce(0) { $0 + $1.par }
    }
    
    /// the summed par for all scored holes in the front 9
    var backParForPlayedHoles: Int {
        return sortedHoles.suffix(9).filter { $0.isScored }.reduce(0) { $0 + $1.par }
    }
    
    /// the summed putts for all holes
    var totalPutts: Int {
        return sortedHoles.reduce(0) { $0 +  $1.numPutts }
    }
    
    /// the summed putts for all holes in the front 9
    var frontPutts: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 +  $1.numPutts }
    }
    
    /// the summed putts for all holes in the back 9
    var backPutts: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 +  $1.numPutts }
    }
    
    /// the summed sand shots for all holes
    var totalSandShots: Int {
        return sortedHoles.reduce(0) { $0 +  $1.sandShots }
    }
    
    /// the summed sand shots for all holes in the front 9
    var frontSandShots: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 +  $1.sandShots }
    }
    
    /// the summed sand shots for all holes in the back 9
    var backSandShots: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 +  $1.sandShots }
    }
    
    /// the summed greens in regulation made for all holes
    var totalGreensInRegulation: Int {
        return sortedHoles.filter { $0.greenInRegulation }.count
    }
    
    /// the summed greens in regulation made for all holes in the front 9
    var frontGreensInRegulation: Int {
        return sortedHoles.prefix(9).filter { $0.greenInRegulation }.count
    }
    
    /// the summed greens in regulation made for all holes in the back 9
    var backGreensInRegulation: Int {
        return sortedHoles.suffix(9).filter { $0.greenInRegulation }.count
    }
    
    /// the summed sand saves made for all holes
    var totalSandSaves: Int {
        return sortedHoles.filter { $0.sandSave }.count
    }
    
    /// the summed sand saves made for all holes in the front 9
    var frontSandSaves: Int {
        return sortedHoles.prefix(9).filter { $0.sandSave }.count
    }
    
    /// the summed sand saves made for all holes in the back 9
    var backSandSaves: Int {
        return sortedHoles.suffix(9).filter { $0.sandSave }.count
    }
    
    /// the summed up and downs made for all holes
    var totalUpAndDowns: Int {
        return sortedHoles.filter { $0.upAndDown }.count
    }
    
    var upAndDownPercentage: Double {
        let completedHoles = sortedHoles.filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalUpAndDowns / completedHoles) * 100
    }
    
    /// the summed up and downs made for all holes in the front 9
    var frontUpAndDowns: Int {
        return sortedHoles.prefix(9).filter { $0.upAndDown }.count
    }
    
    /// the summed up and downs made for all holes in the back 9
    var backUpAndDowns: Int {
        return sortedHoles.suffix(9).filter { $0.upAndDown }.count
    }
    
    /// the summed penalties made for all holes
    var totalPenalties: Int {
        return sortedHoles.reduce(0) { $0 + $1.penalties }
    }
    
    /// the summed penalties made for all holes in the front 9
    var frontPenalties: Int {
        return sortedHoles.prefix(9).reduce(0) { $0 + $1.penalties }
    }
    
    /// the summed penalties made for all holes in the back 9
    var backPenalties: Int {
        return sortedHoles.suffix(9).reduce(0) { $0 + $1.penalties }
    }
    
    /// the green in regulation percentage for all holes
    var totalGirPercentage: Double {
        let completedHoles = sortedHoles.filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalGreensInRegulation) / Double(completedHoles) * 100
    }
    
    /// the green in regulation percentage for all holes in the front 9
    var frontGirPercentage: Double {
        let completedHoles = sortedHoles.prefix(9).filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(frontGreensInRegulation) / Double(completedHoles) * 100
    }
    
    /// the green in regulation percentage for all holes in the back 9
    var backGirPercentage: Double {
        let completedHoles = sortedHoles.suffix(9).filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(backGreensInRegulation) / Double(completedHoles) * 100
    }
    
    var sandSavePercentage: Double {
        let completedHoles = sortedHoles.filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalSandSaves / completedHoles) * 100
    }
    
    /// the average putts per hole for all holes
    var totalAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(totalPutts) / Double(completedHoles)
    }
    
    /// the average putts per hole for all holes in the front 9
    var frontAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.prefix(9).filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(frontPutts) / Double(completedHoles)
    }
    
    /// the average putts per hole for all holes in the back 9
    var backAveragePuttsPerHole: Double {
        let completedHoles = sortedHoles.suffix(9).filter { $0.advancedTracking }.count
        guard completedHoles > 0 else { return 0.0 }
        return Double(backPutts) / Double(completedHoles)
    }
    
}
