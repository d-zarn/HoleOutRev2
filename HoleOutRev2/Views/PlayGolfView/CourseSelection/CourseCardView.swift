//
//  CourseCardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct CourseCardView: View {
    
    @EnvironmentObject private var courseService: CourseService
    private let course: CourseModel
    
    init(for course: CourseModel) {
        self.course = course
    }
    
    var body: some View {
        GroupBox {
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

#Preview {
    let courseService = CourseService()
    CourseCardView(for: courseService.getDefaultCourse())
}
