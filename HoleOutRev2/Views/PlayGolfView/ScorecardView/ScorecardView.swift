//
//  ScorecardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

import SwiftUI

struct ScorecardView: View {
    
    private let course: CourseModel
    @EnvironmentObject private var courseService: CourseService
    
    init(for course: CourseModel) {
        self.course = course
    }
    
    var body: some View {
        ScrollView {
            GroupBox{
                HStack {
                    
                    StatItem("Front", "\(courseService.getFrontPar(for: course))")
                    Spacer()
                    StatItem("Back", "\(courseService.getBackPar(for: course))")
                    Spacer()
                    StatItem("Total", "\(course.par)")
                    
                }
            }
            .padding(.horizontal)
            
            VStack {
                ForEach(Array(course.holes.sorted(by: { $0.holeNumber < $1.holeNumber }))) { hole in
                    HoleCardView(hole: hole)
                }
            }
        }
    }
}

#Preview {
    let courseService = CourseService()
    ScorecardView(for: courseService.getDefaultCourse())
        .environmentObject(courseService)
}
