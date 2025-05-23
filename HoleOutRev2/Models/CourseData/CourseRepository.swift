/**
 Contains the list of courses available to the user.
 Hardcoded for each course. Courses can be retrieved by name or ID.
 */


import Foundation

class CourseRepository {
    
    static let shared = CourseRepository()
    
    private init() {}
    
    /// returns course matching ID given
    func getCourse(byId id: UUID) -> CourseModel? {
        return courses.first { $0.id == id }
    }
    
    /// returns course matching name given
    func getCourse(byName name: String) -> CourseModel? {
        return courses.first { $0.name == name }
    }
    
    /// returns array of all available courses
    func getAllCourses() -> [CourseModel] {
        return courses
    }
    
    /// Available courses
    private let courses: [CourseModel] = [
        .stBoniface,
        .southside,
        .maplewood
    ]
    
}
    
private extension CourseModel {
    
    // St. Boniface Golf Course
    static var stBoniface: CourseModel {
        CourseModel(
            name: "St. Boniface Golf Club",
            address: "100 Rue Youville, Winnipeg, MB",
            blues: 6348,
            whites: 6104,
            reds: 5719,
            par: 72,
            holes: [
                HoleModel(id: 1, par: 4, blues: 357, whites: 340, reds: 320),
                HoleModel(id: 2, par: 4, blues: 365, whites: 255, reds: 292),
                HoleModel(id: 3, par: 4, blues: 379, whites: 368, reds: 320),
                HoleModel(id: 4, par: 4, blues: 379, whites: 361, reds: 346),
                HoleModel(id: 5, par: 3, blues: 163, whites: 145, reds: 127),
                HoleModel(id: 6, par: 4, blues: 332, whites: 326, reds: 317),
                HoleModel(id: 7, par: 4, blues: 282, whites: 271, reds: 256),
                HoleModel(id: 8, par: 4, blues: 366, whites: 355, reds: 339, holeType: .dogLeft),
                HoleModel(id: 9, par: 5, blues: 520, whites: 497, reds: 444, holeType: .dogLeft),
                HoleModel(id: 10, par: 4, blues: 441, whites: 430, reds: 418, holeType: .dogRight),
                HoleModel(id: 11, par: 4, blues: 483, whites: 471, reds: 461),
                HoleModel(id: 12, par: 3, blues: 220, whites: 206, reds: 223),
                HoleModel(id: 13, par: 5, blues: 516, whites: 496, reds: 476),
                HoleModel(id: 14, par: 3, blues: 205, whites: 185, reds: 165),
                HoleModel(id: 15, par: 4, blues: 330, whites: 316, reds: 301),
                HoleModel(id: 16, par: 4, blues: 325, whites: 319, reds: 325),
                HoleModel(id: 17, par: 5, blues: 516, whites: 504, reds: 448, holeType: .dogLeft),
                HoleModel(id: 18, par: 3, blues: 169, whites: 159, reds: 154)
            ]
        )
    }
    
    // Southside Golf Course
    static var southside: CourseModel {
        CourseModel(
            name: "Southside Golf Course",
            address: "2226 Southside Road, Grande Pointe, MB",
            blues: 4696,
            whites: 4190,
            reds: 3806,
            par: 63,
            holes: [
                HoleModel(id: 1, par: 4, blues: 408, whites: 376, reds: 352),
                HoleModel(id: 2, par: 3, blues: 113, whites: 102, reds: 90),
                HoleModel(id: 3, par: 3, blues: 199, whites: 170, reds: 158),
                HoleModel(id: 4, par: 4, blues: 390, whites: 347, reds: 336),
                HoleModel(id: 5, par: 4, blues: 332, whites: 296, reds: 282),
                HoleModel(id: 6, par: 3, blues: 170, whites: 145, reds: 134),
                HoleModel(id: 7, par: 3, blues: 142, whites: 124, reds: 105),
                HoleModel(id: 8, par: 4, blues: 350, whites: 312, reds: 286),
                HoleModel(id: 9, par: 3, blues: 130, whites: 104, reds: 100),
                HoleModel(id: 10, par: 4, blues: 376, whites: 353, reds: 293),
                HoleModel(id: 11, par: 3, blues: 173, whites: 150, reds: 141),
                HoleModel(id: 12, par: 3, blues: 138, whites: 115, reds: 100),
                HoleModel(id: 13, par: 4, blues: 341, whites: 326, reds: 319),
                HoleModel(id: 14, par: 3, blues: 166, whites: 142, reds: 120),
                HoleModel(id: 15, par: 3, blues: 132, whites: 110, reds: 88),
                HoleModel(id: 16, par: 4, blues: 383, whites: 345, reds: 324),
                HoleModel(id: 17, par: 5, blues: 536, whites: 486, reds: 442),
                HoleModel(id: 18, par: 3, blues: 217, whites: 187, reds: 156)
            ]
        )
    }
    
    // Maplewood Golf Club
    static var maplewood: CourseModel {
        CourseModel(
            name: "Maplewood Golf Club",
            address: "19113 Cure Road, St-Pierre-Jolys, MB",
            blues: 5731,
            whites: 5330,
            reds: 4533,
            par: 70,
            holes: [
                HoleModel(id: 1, par: 4, blues: 350, whites: 339, reds: 315),
                HoleModel(id: 2, par: 4, blues: 309, whites: 300, reds: 280),
                HoleModel(id: 3, par: 4, blues: 309, whites: 300, reds: 284),
                HoleModel(id: 4, par: 5, blues: 295, whites: 262, reds: 249, holeType: .dogLeft),
                HoleModel(id: 5, par: 3, blues: 175, whites: 154, reds: 135),
                HoleModel(id: 6, par: 4, blues: 385, whites: 370, reds: 270, holeType: .dogLeft),
                HoleModel(id: 7, par: 3, blues: 161, whites: 145, reds: 128),
                HoleModel(id: 8, par: 4, blues: 325, whites: 302, reds: 247),
                HoleModel(id: 9, par: 4, blues: 388, whites: 348, reds: 303, holeType: .dogRight),
                HoleModel(id: 10, par: 5, blues: 469, whites: 444, reds: 399, holeType: .dogRight),
                HoleModel(id: 11, par: 4, blues: 300, whites: 280, reds: 164),
                HoleModel(id: 12, par: 4, blues: 414, whites: 379, reds: 315),
                HoleModel(id: 13, par: 3, blues: 220, whites: 175, reds: 125, holeType: .dogLeft),
                HoleModel(id: 14, par: 4, blues: 347, whites: 327, reds: 257, holeType: .dogRight),
                HoleModel(id: 15, par: 5, blues: 449, whites: 434, reds: 399, holeType: .dogLeft),
                HoleModel(id: 16, par: 4, blues: 292, whites: 282, reds: 234, holeType: .dogLeft),
                HoleModel(id: 17, par: 4, blues: 379, whites: 339, reds: 304, holeType: .dogRight),
                HoleModel(id: 18, par: 3, blues: 164, whites: 150, reds: 125)]
        )
    }
}
