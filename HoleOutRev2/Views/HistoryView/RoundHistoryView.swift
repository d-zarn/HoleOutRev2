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
                ScrollView {
                    VStack {
                        ForEach(searchResults) { round in
                            NavigationLink {
                                
                            } label: {
                                RoundCardView(round: round)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Saved Rounds")
        .searchable(text: $searchText, prompt: "Search Rounds")
    }
}

#Preview {
    RoundHistoryView()
}
