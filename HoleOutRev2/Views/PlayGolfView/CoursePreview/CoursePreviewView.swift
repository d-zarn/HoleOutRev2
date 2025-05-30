/**
 Shows past rounds played at the course as well as the course overview.
 View shown previous to starting a round / viewing the scorecard using the menu button
 */

import SwiftUI

struct CoursePreviewView: View {
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject private var roundService: RoundService
    @Environment(\.modelContext) private var modelContext
    
    @State private var activeRound: RoundModel?
    @State private var isStartingRound = false
    
    private let course: CourseModel
    private let logger = Logger()
    
    init(for course: CourseModel, navigationPath: Binding<NavigationPath>){
        self.course = course
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                CourseOverviewCard(for: course)
                VStack {
                    HStack {
                        Text("Past Rounds")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if roundService.getRoundsByCourseId(id: course.id).isEmpty {
                        // Show a content unavailable view if there's no rounds played at this course
                        VStack {
                            ContentUnavailableView(
                                "No rounds played at \(course.name)",
                                systemImage: "flag.slash",
                                description: Text("Save a round at this course to see past rounds.")
                            )
                        }
                    } else {
                        // show the list of past rounds as RoundCards in a scrolling list
                        ForEach(roundService.getRoundsByCourseId(id: course.id)) { round in
                            NavigationLink {
                                RoundScorecardView(for: round, navigationPath: $navigationPath)
                            } label: {
                                RoundCardView(round: round)
                                    .padding(.horizontal)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
            }
            // Menu Button used to start a round or preview the scorecard for the course
            VStack {
                Spacer()
                HStack {
                    Menu {
                        // Start Round
                        Button {
                            let newRound = roundService.createNewRound(at: course)
                            navigationPath.append(newRound)
                        } label: {
                            Label("Start Round", systemImage: "figure.golf")
                                .font(.title)
                        }
                        
                        // Scorecard View
                        NavigationLink {
                            ScorecardView(for: course, navigationPath: $navigationPath)
                        } label: {
                            Label("Preview Scorecard", systemImage: "menucard.fill")
                                .font(.title2)
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .opacity(0.8)
                                
                            
                            Image(systemName: "flag.circle.fill")
                                .resizable()
                                .frame(width: 64, height: 64)
                        }
                        .foregroundStyle(.ultraThinMaterial, .blue, .opacity(0.8))
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(course.name)
    }
}
