//
//  HistoryTab.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct HistoryTab: View {
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            RoundHistoryView(navigationPath: $navigationPath)
        }
    }
}

#Preview {
    HistoryTab()
}
