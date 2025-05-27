/**
 Shared view for displaying how far over / under score is relative to par.
 1-9 over is in orange, 10-15 over in red, anything under par is in green
 */

import SwiftUI

struct RelativeScore: View {
    private let par: Int
    private let score: Int
    private let large: Bool
    
    init(par: Int, score: Int, large: Bool = false) {
        self.par = par
        self.score = score
        self.large = large
    }
    
    var body: some View {
        let relative = score - par
        
        switch relative {
        case 0:
            Text("E")
                .foregroundStyle(.blue)
                .font(large ? .title : .body)
        case 1...9:
            Text("+\(relative)")
                .foregroundStyle(.orange)
                .font(large ? .title : .body)
        case let score where score > 9:
            Text("+\(relative)")
                .foregroundStyle(.red)
                .font(large ? .title : .body)
        case _:
            Text("\(relative)")
                .foregroundStyle(.green)
                .font(large ? .title : .body)
            
        }
    }
}

#Preview {
    RelativeScore(par: 3, score: 2)
    RelativeScore(par: 5, score: 5)
    RelativeScore(par: 5, score: 7)
    RelativeScore(par: 5, score: 16)
    RelativeScore(par: 3, score: 2, large: true)
    RelativeScore(par: 5, score: 5, large: true)
    RelativeScore(par: 5, score: 7, large: true)
    RelativeScore(par: 5, score: 16, large: true)
}
