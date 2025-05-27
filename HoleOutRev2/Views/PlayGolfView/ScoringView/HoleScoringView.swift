//
//  ScoringView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-23.
//

import SwiftUI

struct HoleScoringView: View {
    @EnvironmentObject private var roundService: RoundService
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    
    HoleScoringView()
        
}
