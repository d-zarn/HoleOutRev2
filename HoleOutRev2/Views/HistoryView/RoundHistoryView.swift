//
//  RoundHistoryView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-26.
//

import SwiftUI

struct RoundHistoryView: View {
    
    @EnvironmentObject private var roundService: RoundService
    @EnvironmentObject private var courseService: CourseService
    @Binding var navigationPath: NavigationPath
    @State private var searchText = ""
    
    private let logger = Logger()
    
    private var searchResults: [RoundModel] {
        roundService.searchRounds(searchText: searchText, courseService: courseService)
    }
    
    var body: some View {
        Group {
            if searchResults.isEmpty {
                VStack {
                    ContentUnavailableView(
                        "No rounds matching \(searchText)",
                        systemImage: "flag.slash",
                        description: Text("Try searching for a different course / date")
                    )
                }
            } else {
                List {
                    ForEach(searchResults) { round in
                        RoundCardView(round: round)
                            .overlay {
                                NavigationLink(value: round) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            }
                            .foregroundStyle(.primary)
                            .listRowSeparator(.hidden)
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
                .navigationDestination(for: RoundModel.self) { round in
                    RoundScorecardView(for: round, navigationPath: $navigationPath)
                }
            }
        }
        .navigationTitle("Saved Rounds")
        .searchable(text: $searchText, prompt: "Search Rounds")
    }
}

