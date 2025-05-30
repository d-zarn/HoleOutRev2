/**
 Wrapper for the Course Selection & Scoring View navigations.
 */

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

