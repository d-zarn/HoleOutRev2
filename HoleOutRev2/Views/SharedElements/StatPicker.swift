/**
 Reduced size picker wheel used for stat selection in the HoleScoringView
 Layers an invisible button overtop of the wheel to prevent accidental taps when scoring isn't wanted
 */

import SwiftUI

struct StatPicker: View {
    @Binding var value: Int
    @Binding var isTracked: Bool
    
    let range: ClosedRange<Int>
    
    init(value: Binding<Int>, range: ClosedRange<Int> = 0...10, isTracked: Binding<Bool>) {
        self._value = value
        self.range = range
        self._isTracked = isTracked
    }
    
    var body: some View {
        HStack {
            ZStack {
                Picker("", selection: $value) {
                    ForEach(range, id: \.self) { num in
                        Text("\(num)")
                            .font(.largeTitle)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 60, height: 100)
                .opacity(isTracked ? 1.0 : 0.4)
                .onChange(of: value) { _, _ in
                    // mark as tracked when user interacts
                    if !isTracked {
                        isTracked = true
                    }
                }
                
                if !isTracked {
                    // invisible button to detect first tap
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isTracked = true
                        }
                    }
                }
                .frame(width: 60, height: 100)
            }
            .padding(.vertical, 4)
    }
}
    
