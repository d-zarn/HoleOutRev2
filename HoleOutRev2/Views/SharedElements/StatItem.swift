/**
 Shared view for statistics listing. Shades the stat label and value differently as a string
 */

import SwiftUI

struct StatItem: View {
    
    let label: String
    let value: Int
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Text(String(value))
                .fontWeight(.bold)
        }
        .font(.subheadline)
    }
}

#Preview {
    StatItem(label: "Average", value: 92)
}
