//
//  HoleCardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

import SwiftUI

struct RoundHoleCardView: View {
    let hole: HoleModel
    
    var body: some View {
        GroupBox {
            HStack {
                
                YardageMarkers(yardages: hole.yardages)
                
                Spacer()
                
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
                
                VStack(alignment: .leading) {
                    StatItem("Putts", "\(hole.numPutts)")
                    StatItem("Sand Shots", "\(hole.sandShots)")
                    StatItem("Penalties", "\(hole.penalties)")
                }
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
                Text("\(hole.score)")
                    .font(.title)
                    .fontWeight(.bold)
                RelativeScore(par: hole.par, score: hole.score)
                
            }
            Divider()
        }
        .padding(.horizontal)
    }
}
