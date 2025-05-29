//
//  ScorecardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

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
        ZStack {
            ScrollView {
                
                VStack {
                    ForEach(Array(course.holes.sorted(by: { $0.holeNumber < $1.holeNumber }))) { hole in
                        HoleCardView(hole: hole)
                    }
                }
            }
            
            GroupBox{
                HStack {
                    
                    StatItem("Front", "\(courseService.getFrontPar(by: course))")
                    Spacer()
                    StatItem("Back", "\(courseService.getBackPar(by: course))")
                    Spacer()
                    StatItem("Total", "\(course.par)")
                    
                }
            }
            .foregroundStyle(.thinMaterial)
            .padding(.horizontal)
        }
    }
}
