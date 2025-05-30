//
//  RoundCardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-26.
//

import SwiftUI

struct RoundCardView: View {
    
    private var round: RoundModel
    private var isReview: Bool
    @EnvironmentObject private var courseService: CourseService
    
    init(round: RoundModel, isReview: Bool = false) {
        self.round = round
        self.isReview = isReview
    }
    
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Label("\(courseService.getCourse(byID: round.courseId)?.name ?? "Course Unavailable")", systemImage: "house.and.flag.fill")
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundStyle(.blue)
                        Label("\(round.formattedDate)", systemImage: "calendar")
                            .foregroundStyle(.secondary)
                        Label("\(round.formattedDuration)", systemImage: "clock")
                            .foregroundStyle(.secondary)
                        Label("Scored \(round.numHolesScored) / \(courseService.getCourse(byID: round.courseId)?.holes.count ?? 18)", systemImage: "pencil.and.scribble")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if isReview {
                        Text("\(round.totalScore)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    RelativeScore(par: round.totalParForPlayedHoles, score: round.totalScore, large: isReview ? false : true)
                }
                Divider()
                HStack {
                    StatItem("Par", "\(round.totalParForPlayedHoles)")
                    Spacer()
                    StatItem("Front", "\(round.frontScore)")
                    Spacer()
                    StatItem("Back", "\(round.backScore)")
                    if !isReview {
                        Spacer()
                        StatItem("Final Score", "\(round.totalScore)")
                    }
                }
            }

        }
        .padding(.horizontal)
    }
}
