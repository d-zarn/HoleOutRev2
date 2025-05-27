//
//  RoundScoringView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-25.
//

import SwiftUI

struct RoundScoringView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var roundService: RoundService
    
    @State private var round: RoundModel
    @State private var refreshID = UUID()
    @State private var navigationDirection = NavigationDirection.forward
    
    enum NavigationDirection {
        case forward
        case backward
    }
    
    init(round: RoundModel) {
        self._round = State(initialValue: round)
    }
    
    var body: some View {
        VStack {
            
            // Current hole scoring view
            if let currentHole = round.currentHole {
                HoleScoringView(hole: currentHole)
                    .onChange(of: currentHole.score) { _, _ in
                        // Auto-save when score changes
                        roundService.saveRound(round)
                    }
                    .id(refreshID)
                    .transition(navigationDirection == .forward ?
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ) :
                            .asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)
                            ))
                    .animation(.easeInOut(duration: 0.3), value: refreshID)
            } else {
                Text("No hole data available")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            
            // Navigation controls
            
            HStack {
                Button(action: {
                    navigationDirection = .backward
                    withAnimation {
                        round.moveToPreviousHole()
                        refreshID = UUID()
                    }
                    roundService.saveRound(round)
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Previous")
                    }
                    .padding()
                    .cornerRadius(18)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(round.isFirstHole)
                
                if round.isLastHole {
                    
                    NavigationLink {
                        RoundSummaryView(round: round)
                    } label: {
                        HStack {
                            Text("Finish")
                            Image(systemName: "flag.checkered")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(18)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                } else {
                    
                Button(action: {
                    navigationDirection = .forward
                    withAnimation {
                        round.moveToNextHole()
                        refreshID = UUID()
                    }
                    roundService.saveRound(round)
                }) {
                    HStack {
                        Text("Next")
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(18)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
        }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}
