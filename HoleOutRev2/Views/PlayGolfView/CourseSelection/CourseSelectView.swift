//
//  CourseSelectView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct CourseSelectView: View {
    
    @EnvironmentObject private var courseService: CourseService
    @State private var searchText = ""
    
    private let logger = Logger()
    
    private var searchResults: [CourseModel] {
        courseService.searchCourses(searchText: searchText)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if searchResults.isEmpty {
                    VStack {
                        ContentUnavailableView(
                            "No courses matching \(searchText)",
                            systemImage: "flag.slash",
                            description: Text("Try searching for a different course")
                        )
                    }
                } else {
                    ScrollView {
                        VStack {
                            
                            ForEach(searchResults) { course in
                                NavigationLink {
                                    CoursePreviewView(for: course)
                                } label: {
                                    CourseCardView(for: course)
                                }
                                .foregroundStyle(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Course")
            .searchable(text: $searchText, prompt: "Search Courses")
        }   
    }
}

#Preview {
    let courseService = CourseService()
    CourseSelectView()
        .environmentObject(courseService)
}
