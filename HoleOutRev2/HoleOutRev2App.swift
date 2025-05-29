//
//  HoleOutRev2App.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

/// TODO's
/// Add Delete & Save buttons to RoundScoringView
/// Add Scorecard to RoundScoringView
/// Implement PerformanceView
/// Score Composition Stacked Bar Chart in performance
/// Add more courses
/// Watch Counterpart

import SwiftUI
import SwiftData

@main
struct HoleOutRev2App: App {
    
    @StateObject private var roundService: RoundService
    @StateObject private var courseService = CourseService()
    let sharedModelContainer: ModelContainer
    
    init() {
        let schema = Schema([
            RoundModel.self,
            HoleModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.sharedModelContainer = container
            // init the state object for roundService
            _roundService = StateObject(wrappedValue: RoundService(modelContext: container.mainContext))
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(roundService)
        .environmentObject(courseService)
    }
}
