/**
 Shared view for displaying how far over / under score is relative to par.
 1-9 over is in orange, 10-15 over in red, anything under par is in green
 */

import SwiftUI

struct RelativeScore: View {
    private let par: Int
    private let score: Int
    
    init(par: Int, score: Int) {
        self.par = par
        self.score = score
    }
    
    var body: some View {
        let relative = score - par
        
        switch relative {
        case 0:
            Text("E")
                .foregroundStyle(.blue)
        case 1...9:
            Text("+\(relative)")
                .foregroundStyle(.orange)
        case let score where score > 9:
            Text("+\(relative)")
                .foregroundStyle(.red)
        case let _score:
            Text("\(relative)")
                .foregroundStyle(.green)
            
        }
    }
}

#Preview {
    RelativeScore(par: 3, score: 2)
    RelativeScore(par: 5, score: 5)
    RelativeScore(par: 5, score: 7)
    RelativeScore(par: 5, score: 16)
}
