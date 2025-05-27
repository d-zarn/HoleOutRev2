/**
 Represents a golf course.
 Courses have a name, a unique ID, address, total yardages, and an array of holes.
 */

import Foundation
import SwiftUI

class CourseModel: Identifiable {
    
    // Course Identifiers
    var id: Int
    var name: String
    var address: String
    
    // Course Info
    var yardages: Yardages
    var par: Int
    var holes: [HoleModel]
    
    init(id: Int, name: String, address: String, blues: Int, whites: Int, reds: Int, par: Int, holes: [HoleModel]) {
        self.id = id
        self.name = name
        self.address = address
        self.yardages = Yardages(b: blues, w: whites, r: reds)
        self.par = par
        self.holes = holes.sorted { $0.id < $1.id }
    }
}
