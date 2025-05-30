/**
 Represents a hole in a course listing the yardages, par, and user averages for the hole.
 Used in ScorecardView in CoursePreviewView
 */

import SwiftUI

struct HoleCardView: View {
    let hole: HoleModel
    
    var body: some View {
        GroupBox {
            holeStats
        } label: {
            VStack {
                HStack{
                    Label("", systemImage: "\(hole.holeNumber).square.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                    Text("Par \(hole.par)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    StatItem("Avg. Score", "\(hole.par)", isLarge: true)
                    
                }
                Divider()
                YardageMarkers(yardages: hole.yardages, isVertical: false)
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var holeStats: some View {
        HStack {
            VStack(alignment: .leading) {
                StatItem("Avg. Putts", "0.00")
                StatItem("Avg. Sand Shots", "0.00")
                StatItem("Avg. Penalties", "0.00")
            }
            Spacer()
            VStack(alignment: .leading) {
                StatItem("GIR%", "0%")
                StatItem("Sand Save %", "0%")
                StatItem("Up & Down %", "0%")
            }
        }
    }
}
