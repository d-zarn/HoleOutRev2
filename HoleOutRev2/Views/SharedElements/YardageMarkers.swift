/**
 Shared view for yardage markers. Can display in a VStack or even spaced HStack.
 Displayed as coloured marker with yardage next to it in text
 */

import SwiftUI

struct YardageMarkers: View {
    
    // store yardages and pin colour
    let blues: Int
    let whites: Int
    let reds: Int
    let isVertical: Bool
    let markerLeft: Bool
    let isLarge: Bool
    
    // add them in an init
    init(yardages: Yardages, isVertical: Bool = true, markerLeft: Bool = true, isLarge: Bool = false) {
        self.blues = yardages.blues
        self.whites = yardages.whites
        self.reds = yardages.reds
        self.isVertical = isVertical
        self.markerLeft = markerLeft
        self.isLarge = isLarge
    }
    
    var body: some View {
    
        // build circle marker with input colour and yardage
            if isVertical {
                VStack {
                    blueMarker
                    whiteMarker
                    redMarker
                }
            } else {
                HStack {
                    blueMarker
                    Spacer()
                    whiteMarker
                    Spacer()
                    redMarker
                }
            }
            
        
    }
    
    private var blueMarker: some View {
        HStack(spacing: 6) {
            if !isLarge {
                if markerLeft {
                    Circle()
                        .fill(.blue)
                        .frame(width: 10, height: 10)
                }
                Text(String(blues))
                    .font(.footnote)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.blue)
                        .frame(width: 10, height: 10)
                }
            } else {
                if markerLeft {
                    Circle()
                        .fill(.blue)
                        .frame(width: 15, height: 15)
                }
                Text(String(blues))
                    .font(.headline)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.blue)
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
    
    private var whiteMarker: some View {
        HStack(spacing: 6) {
            if !isLarge {
                if markerLeft {
                    Circle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                }
                Text(String(whites))
                    .font(.footnote)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                }
            } else {
                if markerLeft {
                    Circle()
                        .fill(.white)
                        .frame(width: 15, height: 15)
                }
                Text(String(whites))
                    .font(.headline)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.white)
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
    
    private var redMarker: some View {
        HStack(spacing: 6) {
            if !isLarge {
                if markerLeft {
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                }
                Text(String(reds))
                    .font(.footnote)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.red)
                        .frame(width: 10, height: 10)
                }
            } else {
                if markerLeft {
                    Circle()
                        .fill(.red)
                        .frame(width: 15, height: 15)
                }
                Text(String(reds))
                    .font(.headline)
                    .foregroundStyle(.primary)
                if !markerLeft {
                    Circle()
                        .fill(.red)
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
}

#Preview {
    let yards = Yardages(b: 321, w: 315, r: 300)
    
    VStack(spacing: 30) {
        YardageMarkers(yardages: yards, isVertical: false, markerLeft: true)
        YardageMarkers(yardages: yards, isVertical: false, markerLeft: false)
        YardageMarkers(yardages: yards, isVertical: true, markerLeft: true)
        YardageMarkers(yardages: yards, isVertical: true, markerLeft: false)
        YardageMarkers(yardages: yards, isVertical: false, markerLeft: true, isLarge: true)
        YardageMarkers(yardages: yards, isVertical: false, markerLeft: false, isLarge: true)
        YardageMarkers(yardages: yards, isVertical: true, markerLeft: true, isLarge: true)
        YardageMarkers(yardages: yards, isVertical: true, markerLeft: false, isLarge: true)
    }
    .padding()
    .background(Color(.secondarySystemBackground))
}
