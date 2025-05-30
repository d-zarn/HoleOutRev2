/**
 Used to show quick details of a course, name and address.
 Used in CourseSelectView as NavigationLinks
 */

import SwiftUI

struct CourseCardView: View {
    
    @EnvironmentObject private var courseService: CourseService
    private let course: CourseModel
    
    // the course being displayed
    init(for course: CourseModel) {
        self.course = course
    }
    
    var body: some View {
        GroupBox {
            // course name and address
            HStack {
                Label(course.address, systemImage: "location.fill")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
        } label: {
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
                .foregroundStyle(.blue)
        }
        .padding(.horizontal)
    }
}
