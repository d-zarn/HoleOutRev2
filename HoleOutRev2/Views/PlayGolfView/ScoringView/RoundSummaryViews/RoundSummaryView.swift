//
//  RoundSummaryView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-25.
//

import SwiftUI

struct RoundSummaryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var roundService: RoundService
    
    let round: RoundModel
    
    var totalScore: Int {
        round.holes.reduce(0) { $0 + $1.score }
    }
    
    var totalPar: Int {
        round.holes.reduce(0) { $0 + $1.par }
    }
    
    var relativeScore: Int {
        totalScore - totalPar
    }
    
    var relativeScoreText: String {
        if relativeScore == 0 {
            return "Even Par"
        } else if relativeScore > 0 {
            return "+\(relativeScore)"
        } else {
            return "\(relativeScore)"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Round Complete!")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .center, spacing: 8) {
                    Text(round.date, style: .date)
                        .font(.headline)
                    
                    Text("Total Score: \(totalScore)")
                        .font(.title2)
                    
                    Text(relativeScoreText)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(relativeScore <= 0 ? .green : .primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                
                
                HStack(spacing: 20) {
                    NavigationLink {
                        HistoryTab()
                    } label: {
                        Label("Save Round", image: "square.and.arrow.down")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        roundService.completeRound(round)
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 30)
            }
            .padding()
            .navigationTitle("Round Summary")
        }
    }
}

