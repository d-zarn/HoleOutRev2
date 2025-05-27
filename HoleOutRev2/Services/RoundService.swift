//
//  RoundService.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData
import SwiftUI

class RoundService: ObservableObject {
    private let modelContext: ModelContext
    @Published var activeRound: RoundModel?
    
    private let logger = Logger()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Data Operations
    
    func createNewRound(at course: CourseModel) -> RoundModel {
        let newRound = RoundModel(courseId: course.id)
        let sortedCourseHoles = course.holes.sorted { $0.holeNumber < $1.holeNumber }
        
        for hole in sortedCourseHoles {
            let newHole = HoleModel(from: hole)
            newHole.round = newRound
            newRound.holes.append(newHole)
        }
        
        modelContext.insert(newRound)
        
        DispatchQueue.main.async {
            self.activeRound = newRound
        }
        
        logger.log("New round created at \(course.name)")
        return newRound
    }
    
    func completeRound(_ round: RoundModel) {
        round.endTime = Date()
        saveRound(round)
        activeRound = nil
        logger.log("Round completed", level: .success)
    }
    
    func endRound(_ round: RoundModel) {
        round.endTime = Date()
        saveRound(round)
        logger.log("Round ended", level: .success)
    }
    
    /// Saves the round to the model container
    func saveRound(_ round: RoundModel) {
        if round.roundId == activeRound?.roundId {
            activeRound = round
        }
        
        do {
            try modelContext.save()
            logger.log("Round Saved Successfully", level: .success)
            
        } catch {
            logger.log("Error saving round: \(error.localizedDescription)", level: .error)
        }
    }
    
    /// deletes a round from the database
    func deleteRound(_ round: RoundModel) {
        modelContext.delete(round)
        do {
            try modelContext.save()
            logger.log("Round deleted Successfully", level: .success)
        } catch {
            logger.log("Error deleting round: \(error.localizedDescription)", level: .error)
        }
    }
    
    // MARK: - Search Functions
    
    func searchRounds(searchText: String, courseService: CourseService) -> [RoundModel] {
        guard !searchText.isEmpty else {
            return getAllRounds()
        }
        
        let allRounds = getAllRounds()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let matchingCourses = courseService.searchCourses(searchText: searchText)
        let courseIdMatches = Set(matchingCourses.map { $0.id })
        
        return allRounds.filter { round in
            let courseMatch = courseIdMatches.contains(round.courseId)
            
            let dateString = dateFormatter.string(from: round.date)
            let dateMatch = dateString.localizedCaseInsensitiveContains(searchText)
            
            return courseMatch || dateMatch
        }
    }
    
    private func getAllRounds() -> [RoundModel] {
        do {
            let descriptor = FetchDescriptor<RoundModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            return try modelContext.fetch(descriptor)
        } catch {
            logger.log("Error fetching all rounds: \(error.localizedDescription)", level: .error)
            return []
        }
    }
    
    
    
}
