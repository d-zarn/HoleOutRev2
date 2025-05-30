//
//  RoundSummaryView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-25.
//

import SwiftUI

struct RoundSummaryView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(\.selectedTab) private var selectedTab
    @EnvironmentObject private var roundService: RoundService
    @EnvironmentObject private var courseService: CourseService
    
    @State private var isTotalsExpanded = false
    @State private var isFrontExpanded = false
    @State private var isBackExpanded = false
    
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
                
                // Course Detail only show if not in review
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
                
                // total summary
                GroupBox {
                    if isTotalsExpanded {
                    Divider()
                    
                        VStack {
                            
                            HStack {
                                StatItem("Putts:", "\(round.totalPutts)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.totalAveragePuttsPerHole))", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Shots:", "\(round.totalSandShots)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Penalties:", "\(round.totalPenalties)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR:", "\(round.totalGreensInRegulation)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR%:", "\(String(format: "%.2f", round.totalGirPercentage))%", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Saves:", "\(round.totalSandSaves)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Up & Downs:", "\(round.totalUpAndDowns)", isLarge: true)
                                Spacer()
                            }
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
                
                
                // Front 9 Summary
                GroupBox {
                    if isFrontExpanded {
                    Divider()
                    
                        VStack {
                            
                            HStack {
                                StatItem("Putts:", "\(round.frontPutts)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.frontAveragePuttsPerHole))", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Shots:", "\(round.frontSandShots)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Penalties:", "\(round.frontPenalties)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR:", "\(round.frontGreensInRegulation)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR%:", "\(String(format: "%.2f", round.frontGirPercentage))%", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Saves:", "\(round.frontSandSaves)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Up & Downs:", "\(round.frontUpAndDowns)", isLarge: true)
                                Spacer()
                            }
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
                
                // Back 9 Summary
                GroupBox {
                    if isBackExpanded {
                    Divider()
                    
                        VStack {
                            
                            HStack {
                                StatItem("Putts:", "\(round.backPutts)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Putts per Hole:", "\(String(format: "%.2f", round.backAveragePuttsPerHole))", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Shots:", "\(round.backSandShots)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Penalties:", "\(round.backPenalties)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR:", "\(round.backGreensInRegulation)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("GIR%:", "\(String(format: "%.2f", round.backGirPercentage))%", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Sand Saves:", "\(round.backSandSaves)", isLarge: true)
                                Spacer()
                            }
                            
                            HStack {
                                StatItem("Up & Downs:", "\(round.backUpAndDowns)", isLarge: true)
                                Spacer()
                            }
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

            }
            .navigationTitle("Round Summary")
            
            if !isReview {
                HStack {
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
