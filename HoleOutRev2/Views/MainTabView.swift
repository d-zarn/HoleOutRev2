/**
 Wrapper for all tabs within the app
 Passes the selected tab through the environment to allow for changes within views
 */

import SwiftUI

struct SelectedTabKey: EnvironmentKey {
    static let defaultValue: Binding<Int> = .constant(0)
}

extension EnvironmentValues {
    var selectedTab: Binding<Int> {
        get { self[SelectedTabKey.self] }
        set { self[SelectedTabKey.self] = newValue }
    }
}

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
                .tag(2)
        }
        .environment(\.selectedTab, $selectedTab)
    }
}
