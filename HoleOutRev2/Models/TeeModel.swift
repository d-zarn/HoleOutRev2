//
//  Tees.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-31.
//

import Foundation
import SwiftUI
import SwiftData

@Model class TeeModel {
    
    var yardage: Int
    var color: Color
    var rating: Double
    var par: Int
    var slope: Int
    
    init(yardage: Int, color: Color, rating: Double = 0.0, slope: Int = 0, par: Int) {
        self.yardage = yardage
        self.color = color
        self.rating = rating
        self.slope = slope
        self.par = par
    }
    
}
