/**
 Shared view for statistics listing. Shades the stat label and value differently as a string
 */

import SwiftUI

struct StatItem: View {
    
    let label: String
    let value: String
    let isLarge: Bool
    
    init(_ label: String, _ value: String, isLarge: Bool = false) {
        self.label = label
        self.value = value
        self.isLarge = isLarge
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
        .font(isLarge ? .title3 : .subheadline)
    }
}
