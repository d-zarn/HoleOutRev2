/**
 Displays a scrollable Scorecard for the round using RoundHoleCardViews and
 a summary of totalled stats for the whole round and breakdowns for the front and back 9s
 */

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
            // show the round card
            RoundCardView(round: round, isReview: true)
                .padding(.horizontal)
            // displays summarized stats for totals, front, and back 9s
            RoundSummaryView(round: round, navigationPath: $navigationPath, isReview: true)
            // list of RoundHoleCards to make up the scorecard
            VStack {
                ForEach(Array(round.sortedHoles)) { hole in
                    RoundHoleCardView(hole: hole)
                        .padding(.horizontal)
                }
            }
        }
    }
}
