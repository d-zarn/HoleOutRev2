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
                        HistoryTab()
                    } label: {
                        
                        Label("Preview Scorecard", systemImage: "menucard.fill")
                            .font(.title2)
                    }
                } label: {
                    Image(systemName: "flag.circle.fill")
                        .resizable()
                        .opacity(0.5)
                        .frame(width: 64, height: 64)
                }
                Spacer()
            }
            .padding(30)
        }
        .navigationTitle(course.name)
        
//        HStack{
//            Spacer()
//            NavigationLink {
//                HistoryTab()
//            } label: {
//                Label("Scorecard", systemImage: "magnifyingglass.circle.fill")
//                    .font(.title2)
//            }
//    
//            Spacer()
//            
//            NavigationLink {
//                HistoryTab()
//            } label: {
//                Label("Start Round", systemImage: "figure.golf.circle.fill")
//                    .font(.title2)
//            }
//            Spacer()
//        }
//        .padding()
    }
    
}

#Preview {
    let courseService = CourseService()
    CoursePreviewView(for: courseService.getDefaultCourse())
        .environmentObject(courseService)
}
