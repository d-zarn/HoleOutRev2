/**
 Shows the list of available courses as a scrollable, searchable list of CourseCardViews
 Courses can be searched by name or address
 */

import SwiftUI

struct CourseSelectView: View {
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject private var courseService: CourseService
    @State private var searchText = ""
    
    private let logger = Logger()
    
    /// contains courses with a name or address matching the given searchText String
    /// defaults to all available courses if searchText is blank
    private var searchResults: [CourseModel] {
        courseService.searchCourses(searchText: searchText)
    }
    
    var body: some View {
            VStack {
                // show a course unavailable view if there's no courses in searchResults
                if searchResults.isEmpty {
                    VStack {
                        ContentUnavailableView(
                            "No courses matching \(searchText)",
                            systemImage: "flag.slash",
                            description: Text("Try searching for a different course")
                        )
                    }
                    // show the list of courses in searchResults as CourseCardViews
                } else {
                    ScrollView {
                        VStack {
                            ForEach(searchResults) { course in
                                NavigationLink {
                                    CoursePreviewView(for: course, navigationPath: $navigationPath)
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

//#Preview {
//    let courseService = CourseService()
//    CourseSelectView()
//        .environmentObject(courseService)
//}
