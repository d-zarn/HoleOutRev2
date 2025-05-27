//
//  PlayTab.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct PlayGolfTab: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            CourseSelectView(navigationPath: $navigationPath)
                .navigationDestination(for: RoundModel.self) { round in
                    RoundScoringView(round: round, navigationPath: $navigationPath)
                }
        }
    }
}

#Preview {
    let courseService = CourseService()
    PlayGolfTab()
        .environmentObject(courseService)
}
