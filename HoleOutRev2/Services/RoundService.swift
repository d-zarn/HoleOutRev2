/**
 Used for interacting with round CRUD operations
 Saves, ends, deletes, and completes rounds
 */

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
    
    /// Creates a new round model and copies the holes from the given course to the round
    ///
    /// - Parameters:
    ///    - course: The course the round is being played at
    /// - Returns: The populated round model
    func createNewRound(at course: CourseModel) -> RoundModel {
        let newRound = RoundModel(courseId: course.id)
        let sortedCourseHoles = course.holes.sorted { $0.holeNumber < $1.holeNumber }
        
        // copy holes from course to round
        for hole in sortedCourseHoles {
            let newHole = HoleModel(from: hole)
            newHole.round = newRound
            newRound.holes.append(newHole)
        }
        // add the round to the container and set it as active
        modelContext.insert(newRound)
        DispatchQueue.main.async {
            self.activeRound = newRound
        }
        logger.log("New round created at \(course.name)")
        return newRound
    }
    
    
    /// Sets the end time for the given round, saves it, and nullifies the active round
    /// - Parameters:
    /// - round: The round to complete
    func completeRound(_ round: RoundModel) {
        round.endTime = Date()
        saveRound(round)
        activeRound = nil
        logger.log("Round completed", level: .success)
    }
    
    /// Sets the end time and saves the round
    /// - Parameters:
    /// - round: The round to end
    func endRound(_ round: RoundModel) {
        round.endTime = Date()
        saveRound(round)
        logger.log("Round ended", level: .success)
    }
    
    /// Saves the active round to the model container
    /// - Parameters:
    /// - round: The round to be saved
    func saveRound(_ round: RoundModel) {
        if round.roundId == activeRound?.roundId {
            activeRound = round
        }
        
        // try to add save the round
        do {
            try modelContext.save()
            logger.log("Round Saved Successfully", level: .success)
            
        } catch {
            logger.log("Error saving round: \(error.localizedDescription)", level: .error)
        }
    }
    
    /// Deletes a round from the model container
    ///
    /// - Parameters;
    ///   - round: The round to be deleted
    func deleteRound(_ round: RoundModel) {
        // delete the round
        modelContext.delete(round)
        // save the container
        do {
            try modelContext.save()
            logger.log("Round deleted Successfully", level: .success)
        } catch {
            logger.log("Error deleting round: \(error.localizedDescription)", level: .error)
        }
    }
    
    // MARK: - Search Functions
    
    /// Searches for the round based on date and courses using string  input
    /// - Parameters:
    ///   - searchText: The string input used to search
    ///   - courseService: The CourseService to use
    /// - Returns: An array of rounds matching date or course name matching string input, all rounds if the string is empty.
    func searchRounds(searchText: String, courseService: CourseService) -> [RoundModel] {
        // if searchText is empty return all runds
        guard !searchText.isEmpty else {
            return getAllRounds()
        }
        
        // otherwise get all rounds and check the date and courseId for matches to the searchText
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
    
    /// Returns all rounds matching the given courseId
    /// - Parameters:
    ///   - id:the course id to match to
    /// - Returns: An array of rounds matching the course Id given. Empty array if no courses match.
    func getRoundsByCourseId(id: Int) -> [RoundModel] {
        return getAllRounds().filter{ $0.courseId == id }
    }
    
    /// Returns all rounds in the model container
    /// - Returns: An array containing all rounds in the model container
    func getAllRounds() -> [RoundModel] {
        do {
            let descriptor = FetchDescriptor<RoundModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            return try modelContext.fetch(descriptor)
        } catch {
            logger.log("Error fetching all rounds: \(error.localizedDescription)", level: .error)
            return []
        }
    }
}
