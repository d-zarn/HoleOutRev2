//
//  RoundService.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import Foundation
import SwiftData

class RoundService: ObservableObject {
    private let modelContext: ModelContext
    
    private let logger = Logger()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Data Operations
    
    /// Saves the round to the model container
    func saveRound(_ round: RoundModel) {
        modelContext.insert(round)
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
    
}

