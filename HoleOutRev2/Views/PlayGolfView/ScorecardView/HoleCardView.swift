//
//  HoleCardView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

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

#Preview {
    let courseService = CourseService()
    HoleCardView(hole: courseService.getDefaultCourse().holes[5])
        .environmentObject(courseService)
}
