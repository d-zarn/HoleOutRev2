/**
 Overarching view used to display the RoundHistoryView
 */

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
