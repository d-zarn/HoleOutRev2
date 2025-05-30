/**
 Displays a summary for the round given.
 Contains the stat summaries for all holes, and the front and back 9s as collapsible GroupBoxes
 Contains the scorecard for the round if in review mode.
 */

import SwiftUI

struct RoundSummaryView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(\.selectedTab) private var selectedTab
    @EnvironmentObject private var roundService: RoundService
    @EnvironmentObject private var courseService: CourseService
    
    // GroupBox expansion states
    @State private var isTotalsExpanded = false
    @State private var isFrontExpanded = false
    @State private var isBackExpanded = false
    @State private var isScorecardExpanded = false
    
    var isReview: Bool
    
    let round: RoundModel
    
    init(round: RoundModel, navigationPath: Binding<NavigationPath>, isReview: Bool = false) {
        self.round = round
        self._navigationPath = navigationPath
        self.isReview = isReview
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                // Course Detail only shown if not in review
                if !isReview {
                    GroupBox {
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Label("\(round.formattedDate)", systemImage: "calendar")
                                    .foregroundStyle(.secondary)
                                Label("\(round.formattedDuration)", systemImage: "clock")
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(round.totalScore)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        }
                        
                    } label: {
                        Label(
                            "\(courseService.getCourse(byID: round.courseId)?.name ?? "Course Unavailable")",
                            systemImage: "flag.fill"
                        )
                        .font(.title)
                        .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                    .onAppear {
                        round.endTime = Date()
                    }
                }
                
                // MARK: - Summaries
                
                // totals
                GroupBox {
                    if isTotalsExpanded {
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                StatItem("Putts:", "\(round.totalPutts)", isLarge: true)
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.totalAveragePuttsPerHole))", isLarge: true)
                                StatItem("Sand Shots:", "\(round.totalSandShots)", isLarge: true)
                                StatItem("Penalties:", "\(round.totalPenalties)", isLarge: true)
                                StatItem("GIR:", "\(round.totalGreensInRegulation)", isLarge: true)
                                StatItem("GIR%:", "\(String(format: "%.2f", round.totalGirPercentage))%", isLarge: true)
                                StatItem("Sand Saves:", "\(round.totalSandSaves)", isLarge: true)
                                StatItem("Up & Downs:", "\(round.totalUpAndDowns)", isLarge: true)
                            }
                            Spacer()
                        }
                    }
                } label: {
                    HStack {
                        Label("Totals", systemImage: "plus.forwardslash.minus")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                        RelativeScore(par: round.totalParForPlayedHoles, score: round.totalScore, large: true)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring()) {
                        isTotalsExpanded.toggle()
                    }
                }
                .padding(.horizontal)
                
                // Front 9
                GroupBox {
                    if isFrontExpanded {
                        Divider()
                        HStack {
                            VStack {
                                StatItem("Putts:", "\(round.frontPutts)", isLarge: true)
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.frontAveragePuttsPerHole))", isLarge: true)
                                StatItem("Sand Shots:", "\(round.frontSandShots)", isLarge: true)
                                StatItem("Penalties:", "\(round.frontPenalties)", isLarge: true)
                                StatItem("GIR:", "\(round.frontGreensInRegulation)", isLarge: true)
                                StatItem("GIR%:", "\(String(format: "%.2f", round.frontGirPercentage))%", isLarge: true)
                                StatItem("Sand Saves:", "\(round.frontSandSaves)", isLarge: true)
                                StatItem("Up & Downs:", "\(round.frontUpAndDowns)", isLarge: true)
                            }
                            Spacer()
                        }
                    }
                } label: {
                    HStack {
                        Label("Front 9", systemImage: "plus.forwardslash.minus")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                        RelativeScore(par: round.frontParForPlayedHoles, score: round.frontScore, large: true)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring()) {
                        isFrontExpanded.toggle()
                    }
                }
                .padding(.horizontal)
                
                // Back 9
                GroupBox {
                    if isBackExpanded {
                        Divider()
                        HStack {
                            VStack {
                                StatItem("Putts:", "\(round.backPutts)", isLarge: true)
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.backAveragePuttsPerHole))", isLarge: true)
                                StatItem("Sand Shots:", "\(round.backSandShots)", isLarge: true)
                                StatItem("Penalties:", "\(round.backPenalties)", isLarge: true)
                                StatItem("GIR:", "\(round.backGreensInRegulation)", isLarge: true)
                                StatItem("GIR%:", "\(String(format: "%.2f", round.backGirPercentage))%", isLarge: true)
                                StatItem("Sand Saves:", "\(round.backSandSaves)", isLarge: true)
                                StatItem("Up & Downs:", "\(round.backUpAndDowns)", isLarge: true)
                            }
                            Spacer()
                        }
                    }
                } label: {
                    HStack {
                        Label("Back 9", systemImage: "plus.forwardslash.minus")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                        RelativeScore(par: round.backParForPlayedHoles, score: round.backScore, large: true)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring()) {
                        isBackExpanded.toggle()
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Scorecard
                
                // only displayed in review
                if !isReview {
                    GroupBox {
                        if isScorecardExpanded {
                            ForEach(Array(round.sortedHoles)) { hole in
                                RoundHoleCardView(hole: hole)
                            }
                        }
                    } label: {
                        Label("Scorecard", systemImage: "pencil.and.scribble")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isScorecardExpanded.toggle()
                        }
                    }
                    .padding(.horizontal)
                }
            }
                .navigationTitle("Round Summary")
            
            // MARK: - Buttons
            
            // Save & Delete Buttons
            if !isReview {
                HStack {
                    
                    // Save
                    Button {
                        roundService.completeRound(round)
                        navigationPath = NavigationPath()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            selectedTab.wrappedValue = 1
                        }
                    } label: {
                        Label("Save Round", systemImage: "square.and.arrow.down.fill")
                            .frame(maxWidth: .infinity, minHeight: 60)
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    
                    // Delete
                    Button {
                        roundService.deleteRound(round)
                        navigationPath = NavigationPath()
                    } label: {
                        Label("Delete Round", systemImage: "trash.fill")
                            .frame(maxWidth: .infinity, minHeight: 60)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding(.horizontal)
            }
        }
    }
}
