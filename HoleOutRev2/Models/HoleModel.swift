/**
 Represents the hole. Each hole gets an integer ID to indicate its order, a par, yardages, and a type
 */

import Foundation
import SwiftData

/// type indicates direction of the hole
enum HoleType: String, Codable {
    case straight = "arrowshape.up.fill"
    case dogLeft = "arrowshape.turn.up.left.fill"
    case dogRight = "arrowshape.turn.up.right.fill"
}

@Model
final class HoleModel {
    
    // identifiers and details
    var id: UUID
    var holeNumber: Int
    var holeType: HoleType
    
    // scoring variable
    var isScored: Bool
    var score: Int
    
    // detailed scoring variables
    var advancedTracking: Bool
    var numPutts: Int
    var sandShots: Int
    var penalties: Int
    
    // Extra tracking variables
    var greenInRegulation: Bool
    var sandSave: Bool
    var upAndDown: Bool
    
    @Relationship var tees: [TeeModel]
    
    @Relationship var round: RoundModel?
    
    init(id holeNumber: Int, tees: [TeeModel], holeType: HoleType = .straight) {
        // identifiers and details
        self.id = UUID()
        self.holeNumber = holeNumber
        self.tees = tees
        self.holeType = holeType
        
        //scoring variables
        self.score = tees[0].par
        self.isScored = false
        
        // detailed scoring
        self.advancedTracking = false
        self.numPutts = 0
        self.sandShots = 0
        self.penalties = 0
        
        // boolean scoring indicators
        self.greenInRegulation = false
        self.sandSave = false
        self.upAndDown = false
    }
    
    convenience init(from hole: HoleModel) {
        self.init(
            id: hole.holeNumber,
            tees: hole.tees,
            holeType: hole.holeType,
        )
    }
    
}
