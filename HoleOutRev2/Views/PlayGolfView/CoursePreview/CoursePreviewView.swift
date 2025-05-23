//
//  CoursePreviewView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct CoursePreviewView: View {
    @EnvironmentObject private var courseService: CourseService
    @Environment(\.modelContext) private var modelContext
    
    private let course: CourseModel
    
    private let logger = Logger()
    
    init(for course: CourseModel){
        self.course = course
    }
    
    var body: some View {
        Group {
            ScrollView {
                
                CourseOverviewCard(for: course)
                
            }
            // Menu Button
            HStack {
                Menu {
                    // Start Round
                    NavigationLink {
                        HistoryTab()
                    } label: {
                        Label("Start Round", systemImage: "figure.golf")
                            .font(.title)
                    }
                    
                    // Scorecard View
                    NavigationLink {
                        ScorecardView(for: course)
                    } label: {
                        
                        Label("Preview Scorecard", systemImage: "menucard.fill")
                            .font(.title2)
                    }
                } label: {
                    Image(systemName: "flag.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                Spacer()
            }
            .padding(30)
        }
        .navigationTitle(course.name)
    }
    
}

#Preview {
    let courseService = CourseService()
    CoursePreviewView(for: courseService.getDefaultCourse())
        .environmentObject(courseService)
}
