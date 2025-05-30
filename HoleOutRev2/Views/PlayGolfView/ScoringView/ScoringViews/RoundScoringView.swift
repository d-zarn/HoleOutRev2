/**
 The view shown overlaying the HoleScoringView when in Scoring mode.
 Contains the navigation buttons and logic
 */

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
                // in case of error
                Text("No hole data available")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            
            // Navigation & Round controls
            VStack {
                HStack {
                    // back button
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
                    // disable the button at the first hole
                    .disabled(round.isFirstHole)
                    
                    // if at last hole show the finish round button to move to summary
                    // otherwise show the next hole button
                    if round.isLastHole {
                        finishRoundButton
                    } else {
                        // next hole button
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
                // Finish round menu for exiting a round early and skipping to summary or deleting the round
                Menu {
                    // Delete Round
                    Button {
                        roundService.deleteRound(round)
                        navigationPath = NavigationPath()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            selectedTab.wrappedValue = 0
                        }
                    } label: {
                        Label("Delete Round", systemImage: "trash.fill")
                    }
                    
                    // View Summary
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
                    // Finish Round Menu Label
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
    
    // Button shown at last hole in place of next
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
