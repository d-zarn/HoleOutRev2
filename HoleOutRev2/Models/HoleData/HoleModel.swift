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

import Foundation
import SwiftData

@Model
final class HoleModel {
    
    // identifiers and details
    var id: UUID
    var holeNumber: Int
    var par: Int
    var yardages: Yardages
    var holeType: HoleType
    
    // scoring variables
    var score: Int?
    var isScored: Bool
    var greenInRegulation: Bool
    
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
        self.greenInRegulation = false
    }
}
