//
//  StatPicker.swift
//  HoleOutRev2
//
//  Created by Dylan Zarn on 2025-05-25.
//

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
                // mark as tracked for user interaction
                if !isTracked {
                    isTracked = true
                }
            }
            .overlay(
                Group {
                    if !isTracked {
                        // invisible button to detect first tap
                        Button("") {
                            isTracked = true
                        }
                        .buttonStyle(.plain)
                    }
                }
            )
        }
        .padding(.vertical, 4)
    }
}
