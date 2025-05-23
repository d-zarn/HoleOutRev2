//
//  PlayTab.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct PlayGolfTab: View {
    var body: some View {
        CourseSelectView()
    }
}

#Preview {
    let courseService = CourseService()
    PlayGolfTab()
        .environmentObject(courseService)
}
