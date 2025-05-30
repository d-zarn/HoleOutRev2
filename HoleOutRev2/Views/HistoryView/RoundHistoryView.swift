/**
 Displays the list of saved rounds as RoundCardViews. Searchable by date and course.
 */

import SwiftUI

struct RoundHistoryView: View {
    
    @EnvironmentObject private var roundService: RoundService
    @EnvironmentObject private var courseService: CourseService
    @Binding var navigationPath: NavigationPath
    @State private var searchText = ""
    
    private let logger = Logger()
    
    // array of courses matching date or course name in searchText
    private var searchResults: [RoundModel] {
        roundService.searchRounds(searchText: searchText, courseService: courseService)
    }
    
    var body: some View {
        Group {
            // display content unavailable if no rounds are available / played
            if searchResults.isEmpty {
                VStack {
                    ContentUnavailableView(
                        "No rounds matching \(searchText)",
                        systemImage: "flag.slash",
                        description: Text("Save more rounds or try searching for a different course / date")
                    )
                }
            // display the list of saved rounds
            } else {
                List {
                    ForEach(searchResults) { round in
                        RoundCardView(round: round)
                        // overlay navigationLink to remove list chevron indicator
                            .overlay {
                                NavigationLink(value: round) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            }
                            .foregroundStyle(.primary)
                            .listRowSeparator(.hidden)
                            // delete button revealed on left swipe for removing rounds from container
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    roundService.deleteRound(round)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
                .listStyle(.plain)
                // tapping on RoundCards navigates to the RoundScorecard for that round
                .navigationDestination(for: RoundModel.self) { round in
                    RoundScorecardView(for: round, navigationPath: $navigationPath)
                }
            }
        }
        .navigationTitle("Saved Rounds")
        .searchable(text: $searchText, prompt: "Search Rounds")
    }
}

