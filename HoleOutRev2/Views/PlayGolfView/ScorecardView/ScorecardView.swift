//
//  ScorecardView.swift
/**
 Display the list of holes on the course to form a scorecard for CoursePreviewView.
 */

import SwiftUI

struct ScorecardView: View {
    @Binding var navigationPath: NavigationPath
    private let course: CourseModel
    @EnvironmentObject private var courseService: CourseService
    
    init(for course: CourseModel, navigationPath: Binding<NavigationPath>) {
        self.course = course
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        GroupBox{
            HStack {
                // show the pars for the course
                StatItem("Front", "\(courseService.getFrontPar(by: course))")
                Spacer()
                StatItem("Back", "\(courseService.getBackPar(by: course))")
                Spacer()
                StatItem("Total", "\(course.par)")
                
            }
        }
        .padding(.horizontal)
        
        ScrollView {
                // The list of holes in the course
                VStack {
                    ForEach(Array(course.holes.sorted(by: { $0.holeNumber < $1.holeNumber }))) { hole in
                        HoleCardView(hole: hole)
                    }
                }
        }
    }
}
