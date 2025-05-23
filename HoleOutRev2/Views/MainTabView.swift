//
//  MainTabView.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-22.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // History Tab
            HistoryTab()
                .tabItem {
                    Label("History", systemImage: "book.pages")
                }
                .tag(1)
            
            // Play Golf Tab
            PlayGolfTab()
                .tabItem {
                    Label("Play Golf", systemImage: "figure.golf")
                }
                .tag(0)
            
            // Performance Tab
            PerformanceTab()
                .tabItem {
                    Label("Performance", systemImage: "gauge.with.needle.fill")
                }
        }
    }
}

#Preview {
    let courseService = CourseService()
    MainTabView()
        .environmentObject(courseService)
}
