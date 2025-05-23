//
//  CourseService.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData

class CourseService: ObservableObject {
    private let courseRepository: CourseRepository
    
    private let logger = Logger()
    
    init() {
        courseRepository = CourseRepository.shared
    }
 
    // MARK: - Access Methods
    
    /// Returns all avaliable courses
    /// - Returns: Array of all courses
    func getAllCourses() -> [CourseModel] {
        logger.log("Getting all courses")
        return courseRepository.getAllCourses()
    }
    
    /// Finds a course by its ID
    /// - Parameter id: The UUID of the course to return
    /// - Returns: The matching course, nil if not found
    func getCourse(byID id: UUID) -> CourseModel? {
        logger.log("Looking up course by ID: \(id)")
        return courseRepository.getCourse(byId: id)
    }
    
    /// Finds a course by its name
    /// - Parameter name: The name of the course to return
    /// - Returns: The matching course, nil if not found
    func getCourse(byName name: String) -> CourseModel? {
        logger.log("Looking up course by name: \(name)")
        return courseRepository.getCourse(byName: name)
    }
    
    /// Returns a default course to use as a fallback
    /// - Returns: The first course from the repository
    func getDefaultCourse() -> CourseModel {
        logger.log("Getting default course", level: .info)
        return courseRepository.getAllCourses()[0]
    }
    
    // MARK: - Search Functionality
    
    /// Filters courses based on a search term
    /// - Parameter searchText: The text to search for
    /// - Returns: Array of courses matching the search by name or address
    func searchCourses(searchText: String) -> [CourseModel] {
        guard !searchText.isEmpty else {
            return getAllCourses()
        }
        
        logger.log("Searching courses with term: \(searchText)")
        return getAllCourses().filter { course in
            course.name.localizedCaseInsensitiveContains(searchText) ||
            course.address.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: - Computed Properties
    
    func getFrontPar(for course: CourseModel) -> Int {
        let holes = course.holes.sorted(by: { $0.holeNumber < $1.holeNumber })
        return holes.prefix(9).reduce(0) { $0 + $1.par }
    }
    
    func getBackPar(for course: CourseModel) -> Int {
        let holes = course.holes.sorted(by: { $0.holeNumber < $1.holeNumber })
        return holes.suffix(9).reduce(0) { $0 + $1.par }
    }
    
}
