//
//  ScorecardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

import SwiftUI

struct RoundScorecardView: View {
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject private var courseService: CourseService
    private let round: RoundModel
    
    init(for round: RoundModel, navigationPath: Binding<NavigationPath>) {
        self.round = round
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        ScrollView {
            RoundCardView(round: round, isReview: true)
            RoundSummaryView(round: round, navigationPath: $navigationPath, isReview: true)
            VStack {
                ForEach(Array(round.sortedHoles)) { hole in
                    RoundHoleCardView(hole: hole)
                }
            }
        }
    }
}
