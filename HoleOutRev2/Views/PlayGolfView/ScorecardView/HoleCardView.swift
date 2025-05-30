/**
 Represents a hole in a course listing the yardages, par, and user averages for the hole.
 Used in ScorecardView in CoursePreviewView
 */

import SwiftUI

struct HoleCardView: View {
    let hole: HoleModel
    
    var body: some View {
        GroupBox {
            HStack {
                YardageMarkers(yardages: hole.yardages)
                Spacer()
                holeStats
            }
        } label: {
            HStack{
                Label("", systemImage: "\(hole.holeNumber).square.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                Text("Par \(hole.par)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                StatItem("Avg. Score", "\(hole.par)")
                
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var holeStats: some View {
        VStack(alignment: .leading) {
            StatItem("Avg. Putts", "0")
            StatItem("Fairways", "0%")
            StatItem("GIR", "0%")
        }
    }
    
}
