/**
 Shared view for statistics listing. Shades the stat label and value differently as a string
 */

import SwiftUI

struct StatItem: View {
    
    let label: String
    let value: String
    
    init(_ label: String, _ value: String) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(label)
                    .foregroundStyle(.secondary)
            }
            VStack(alignment: .trailing){
                Text(value)
                    .fontWeight(.bold)
            }
        }
        .font(.subheadline)
    }
}

#Preview {
    StatItem("Average", "92")
}
