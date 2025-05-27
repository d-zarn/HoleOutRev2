//
//  ScoringView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

import SwiftUI

struct HoleScoringView: View {
    @Bindable var hole: HoleModel
    
    private var puttRange: ClosedRange<Int> {
        let maxPutts = max(0, hole.score - hole.sandShots - hole.penalties - 1)
        return 0...maxPutts
    }
    
    private var sandShotRange: ClosedRange<Int> {
        let maxSandShots = max(0, hole.score - hole.numPutts - hole.penalties - 1)
        return 0...maxSandShots
    }
    
    private var penaltiesRange: ClosedRange<Int> {
        let maxPenalties = max(0, hole.score - hole.numPutts - hole.sandShots - 1)
        return 0...maxPenalties
    }
    
    private var madeGIR: Bool {
        if hole.score - hole.numPutts <= hole.par - 2 {
            hole.greenInRegulation = true
            return true
        } else {
            return false
        }
    }
    
    private var sandSave: Bool {
        if hole.score <= hole.par
            && (1..<3) ~= hole.sandShots
            && hole.numPutts < 3 {
            
            hole.sandSave = true
            return true
            
        } else {
            return false
        }
    }
    
    private var upAndDown: Bool {
        if !madeGIR && hole.numPutts == 1 {
            hole.upAndDown = true
            return true
        } else {
            return false
        }
    }
    
    private var isScored: Bool {
        if hole.isScored || hole.advancedTracking {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                // Hole details and scoring wheel
                Label("", systemImage: "\(hole.holeNumber).square.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(.green)
                YardageMarkers(yardages: hole.yardages, isLarge: true)
                Spacer()
                
                // Relative Score
                
                if isScored {
                    RelativeScore(par: hole.par, score: hole.score, large: true)
                        .frame(width: 50)
                } else {
                    Text("Score:")
                        .font(.title)
                }
                
                // Score Picker
                StatPicker(
                    value: $hole.score,
                    range: 1...15,
                    isTracked: $hole.isScored
                )
            }
            .padding()
            
            // Detailed Scoring
            // Putts picker
            HStack {
                Text("Putts:")
                    .font(.largeTitle)
                    .foregroundStyle(hole.advancedTracking ? .primary : .secondary)
                    .padding()
                
                Spacer()
                
                StatPicker(
                    value: $hole.numPutts,
                    range: puttRange,
                    isTracked: $hole.advancedTracking
                )
            }
            .padding(.horizontal)
            
            // Sand Shot picker
            HStack {
                Text("Sand Shots:")
                    .font(.largeTitle)
                    .foregroundStyle(hole.advancedTracking ? .primary : .secondary)
                    .padding()
                Spacer()
                StatPicker(
                    value: $hole.sandShots,
                    range: sandShotRange,
                    isTracked: $hole.advancedTracking
                )
            }
            .padding(.horizontal)
            
            // Penalties picker
            HStack {
                Text("Penalties:")
                    .font(.largeTitle)
                    .foregroundStyle(hole.advancedTracking ? .primary : .secondary)
                    .padding()
                Spacer()
                StatPicker(
                    value: $hole.penalties,
                    range: penaltiesRange,
                    isTracked: $hole.advancedTracking
                )
            }
            .padding(.horizontal)
            
            // GIR, Up & Down, Sand Save markers
            HStack {
                // GIR
                RoundedRectangle(cornerRadius: 18)
                    .overlay() {
                        Text("GIR")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                    .foregroundStyle(madeGIR ? .green : .secondary)
                    .frame(maxHeight: 50)
                    .padding(.leading)
                
                // Sand Save
                RoundedRectangle(cornerRadius: 18)
                    .overlay() {
                        Text("Sand Save")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                    .foregroundStyle(sandSave ? .green : .secondary)
                    .frame(width: 100, height: 50)
                    .padding(.horizontal)
                
                // Up & Down
                RoundedRectangle(cornerRadius: 18)
                    .overlay() {
                        Text("Up & Down")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                    .foregroundStyle(upAndDown ? .green : .secondary)
                    .frame(maxHeight: 50)
                    .padding(.trailing)
            }
            Spacer()
        }
    }
}

#Preview {
    let courseService = CourseService()
    HoleScoringView(hole: courseService.getDefaultCourse().holes[5])
        .environmentObject(courseService)
        
}
