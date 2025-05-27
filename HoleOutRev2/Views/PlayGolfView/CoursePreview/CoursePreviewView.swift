//
//  CoursePreviewView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

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
        VStack {
            ScrollView {
                CourseOverviewCard(for: course)
            }
            // Menu Button
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
                    Image(systemName: "flag.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                Spacer()
            }
            .padding(30)
        }
        
        .navigationTitle(course.name)
    }
}
