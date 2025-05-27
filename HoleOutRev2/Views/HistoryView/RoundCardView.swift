//
//  RoundCardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-26.
//

import SwiftUI

struct RoundCardView: View {
    
    private var round: RoundModel
    @EnvironmentObject private var courseService: CourseService
    
    init(round: RoundModel) {
        self.round = round
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
                    }
                    Spacer()
                    RelativeScore(par: courseService.getTotalPar(by: round.courseId), score: round.totalScore, large: true)
                }
                Divider()
                HStack {
                    StatItem("Par", "\(courseService.getTotalPar(by: round.courseId))")
                    Spacer()
                    StatItem("Front", "\(round.frontScore)")
                    Spacer()
                    StatItem("Back", "\(round.backScore)")
                    Spacer()
                    StatItem("Final Score", "\(round.totalScore)")
                }
            }

        }
        .padding(.horizontal)
    }
}

#Preview {
    let courseService = CourseService()
    RoundCardView(round: RoundModelMock.completeRound())
        .environmentObject(courseService)
}
