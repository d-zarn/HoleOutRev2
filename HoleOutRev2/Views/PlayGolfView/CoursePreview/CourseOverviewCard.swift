/**
 Displays course details. Includes to, and front / back 9 par, tee total yardages, address
 Used in the CourseDetailSheet
 */

import SwiftUI

struct CourseOverviewCard: View {
    
    private let course: CourseModel
    private let logger = Logger()
    
    init(for course: CourseModel) {
        self.course = course
    }
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                Label(course.address, systemImage: "location.fill")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Label("Par \(course.par)", systemImage: "dot.scope")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Divider()
                HStack {
                    YardageMarkers(yardages: course.yardages,isVertical: false, markerLeft: false)
                }
            }
        } label: {
            Text("Course Overview")
        }
        .padding(.horizontal)
    }
}
