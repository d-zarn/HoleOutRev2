/**
 Used to change the score on a hole when in Scoring mode
 Shows course details and picker wheels for each stat
 Range for each stat changes dynamically based on the value of others
 */

import SwiftUI

struct HoleScoringView: View {
    @Bindable var hole: HoleModel
    
    /// Range possible for the amount of putts taken on a hole.
    /// 0 to score - sand shots - penalties - 1 tee shot
    private var puttRange: ClosedRange<Int> {
        let maxPutts = max(0, hole.score - hole.sandShots - hole.penalties - 1)
        return 0...maxPutts
    }
    
    /// Range possible for the amount of sand shots taken
    /// 0 to score - putts - penalties - 1 tee shot
    private var sandShotRange: ClosedRange<Int> {
        let maxSandShots = max(0, hole.score - hole.numPutts - hole.penalties - 1)
        return 0...maxSandShots
    }
    
    /// Range for the amount of penalties taken
    /// 0 to score - putts - sandShots - 1 tee shot
    private var penaltiesRange: ClosedRange<Int> {
        let maxPenalties = max(0, hole.score - hole.numPutts - hole.sandShots - 1)
        return 0...maxPenalties
    }
    
    /// Whether or not green was reached in regulation.
    /// GIR is always hole par - 2.
    /// GIR is reached when score - putts is less than or equal to GIR
    private var madeGIR: Bool {
        if hole.score - hole.numPutts <= hole.par - 2 {
            hole.greenInRegulation = true
            return true
        } else {
            return false
        }
    }
    
    /// Whether or not a snad save was made.
    /// Occurs when a player makes 1-2 sand shots,
    /// and takes no more than 2 putts to stay at or under par
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
    
    /// Whether or not the player got up & down
    /// Occurs when a player takes a single putt outside of GIR.
    /// Up (onto the green) & down (one putt to the hole)
    private var upAndDown: Bool {
        if !madeGIR && hole.numPutts == 1 {
            hole.upAndDown = true
            return true
        } else {
            return false
        }
    }
    
    /// Whether or not the hole has been scored
    /// True when either the score is marked or advanced tracking has been marked
    private var isScored: Bool {
        if hole.isScored || hole.advancedTracking {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            GroupBox {
                HStack {
                    
                    // MARK: - Hole details and scoring picker
                    Label("", systemImage: "\(hole.holeNumber).square.fill")
                        .font(.system(size: 90))
                        .foregroundStyle(.green)
                    YardageMarkers(yardages: hole.yardages, isLarge: true)
                    Spacer()
                    
                    // Relative Score shows if the score is set.
                    // Otherwise indicate that the wheel is for scoring
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
            }
            .padding()
            
            // MARK: - Detailed Scoring
            
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
