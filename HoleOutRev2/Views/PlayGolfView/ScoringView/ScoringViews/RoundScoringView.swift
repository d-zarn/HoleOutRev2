//
//  RoundScoringView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-25.
//

import SwiftUI

struct RoundScoringView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var roundService: RoundService
    @Environment(\.selectedTab) private var selectedTab
    
    @State private var round: RoundModel
    @State private var refreshID = UUID()
    @State private var navigationDirection = NavigationDirection.forward
    
    let logger = Logger()
    
    enum NavigationDirection {
        case forward
        case backward
    }
    
    init(round: RoundModel, navigationPath: Binding<NavigationPath>) {
        self._round = State(initialValue: round)
        self._navigationPath = navigationPath
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
            
            // Navigation & Round controls
            VStack {
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
                    .padding(.leading)
                    .disabled(round.isFirstHole)
                    
                    if round.isLastHole {
                        finishRoundButton
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
                        .padding(.trailing)
                    }
                }
                Menu {
                    Button {
                        roundService.deleteRound(round)
                        navigationPath = NavigationPath()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            selectedTab.wrappedValue = 0
                        }
                    } label: {
                        Label("Delete Round", systemImage: "trash.fill")
                    }
                    
                    NavigationLink {
                        RoundSummaryView(round: round, navigationPath: $navigationPath)
                    } label: {
                        Label("View Summary", systemImage: "plus.forwardslash.minus")
                    }
                    .onTapGesture {
                        roundService.completeRound(round)
                    }
                    .tint(.green)
                } label: {
                    Label("Finish Round", systemImage: "flag.pattern.checkered")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var finishRoundButton: some View {
        NavigationLink {
            RoundSummaryView(round: round, navigationPath: $navigationPath)
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
    }
}
