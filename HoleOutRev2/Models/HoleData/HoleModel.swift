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
    var par: Int
    var yardages: Yardages
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
    
    @Relationship var round: RoundModel?
    
    init(id holeNumber: Int, par: Int, blues: Int, whites: Int, reds: Int, holeType: HoleType = .straight) {
        // identifiers and details
        self.id = UUID()
        self.holeNumber = holeNumber
        self.par = par
        self.yardages = Yardages(b: blues, w: whites, r: reds)
        self.holeType = holeType
        
        //scoring variables
        self.score = par
        self.isScored = false
        
        // detailed scoring
        self.advancedTracking = false
        self.numPutts = 0
        self.sandShots = 0
        self.penalties = 0
   
        self.greenInRegulation = false
        self.sandSave = false
        self.upAndDown = false
    }
    
    convenience init(from hole: HoleModel) {
        self.init(
            id: hole.holeNumber,
            par: hole.par,
            blues: hole.yardages.blues,
            whites: hole.yardages.whites,
            reds: hole.yardages.reds,
            holeType: hole.holeType
        )
    }
    
}
