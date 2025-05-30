/**
 Displays scoring details of the hole for the round
 */

import SwiftUI

struct RoundHoleCardView: View {
    let hole: HoleModel
    
    var body: some View {
        GroupBox {
            HStack {
                YardageMarkers(yardages: hole.yardages)
                Spacer()
                // Boolean scoring indicators, green if true, grey if false
                VStack(alignment: .leading) {
                    Text("GIR")
                        .fontWeight(.black)
                        .foregroundStyle(hole.greenInRegulation ? .green : .secondary)
                    Text("Sand Save")
                        .fontWeight(.black)
                        .foregroundStyle(hole.sandSave ? .green : .secondary)
                    Text("Up & Down")
                        .fontWeight(.black)
                        .foregroundStyle(hole.upAndDown ? .green : .secondary)
                }
                Spacer()
                // Counting Stats
                VStack(alignment: .leading) {
                    StatItem("Putts", "\(hole.numPutts)")
                    StatItem("Sand Shots", "\(hole.sandShots)")
                    StatItem("Penalties", "\(hole.penalties)")
                }
            }
        } label: {
            HStack{
                // Hole number, par, score, and relative score all displayed in the box label
                Label("", systemImage: "\(hole.holeNumber).square.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                Text("Par \(hole.par)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("\(hole.score)")
                    .font(.title)
                    .fontWeight(.bold)
                RelativeScore(par: hole.par, score: hole.score)
                
            }
            Divider()
        }
    }
}
