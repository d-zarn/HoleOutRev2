/**
 Used to display quick details of the round
 */

import SwiftUI

struct RoundCardView: View {
    
    private var round: RoundModel
    // indicates if we're in a round summary or elsewhere
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
                    // Course name, round date, duration, and the number of holes played
                    VStack(alignment: .leading) {
                        // course name
                        Label("\(courseService.getCourse(byID: round.courseId)?.name ?? "Course Unavailable")", systemImage: "house.and.flag.fill")
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundStyle(.blue)
                        // round date
                        Label("\(round.formattedDate)", systemImage: "calendar")
                            .foregroundStyle(.secondary)
                        // round duration
                        Label("\(round.formattedDuration)", systemImage: "clock")
                            .foregroundStyle(.secondary)
                        // number of holes played. Defaults number of holes in a course to 18 if there's an error retrieving the course
                        Label("Scored \(round.numHolesScored) / \(courseService.getCourse(byID: round.courseId)?.holes.count ?? 18)", systemImage: "pencil.and.scribble")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    // if in review, show total score as well as relative score to the played holes
                    if isReview {
                        Text("\(round.totalScore)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    RelativeScore(par: round.totalParForPlayedHoles, score: round.totalScore, large: isReview ? false : true)
                }
                Divider()
                // Show the par for the holes played, score on the front, and score on the back.
                // If not in review show total score as well
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
    }
}
