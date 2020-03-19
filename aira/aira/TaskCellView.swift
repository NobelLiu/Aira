//
//  TaskCellView.swift
//  aira
//
//  Created by Nobel on 2020/3/17.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

struct TaskCellView: View {
    
    private enum Status: Int {
        case hover, selected, disable
    }
    
    @State private var status: [Status] = []
    @State private var sliderValue: Double = 5
    private let maxValue: Double = 10
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("204_introducing_swiftui_building_your_first_app.pdf")
                    .lineLimit(1)
                    .font(Font.system(size: 16))
                    //                    .strikethrough()
                    .foregroundColor(Color.primary)
                HStack {
                    Text("16.4 MB")
                        .font(Font.system(size: 14))
                        .frame(width: 60, alignment: .leading)
                    
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text("52.4")
                            .font(Font.system(size: 14))
                        Text("%")
                            .font(Font.system(size: 10))
                    }
                    ProgressBar(value: $sliderValue.wrappedValue,
                                maxValue: self.maxValue)
                        .frame(width: 120, height: 4)
                }
                .font(Font.system(size: 12))
                .foregroundColor(Color.secondary)
            }
            Spacer()
            HStack {
                if status.contains(.hover) {
                    Image("pause")
                    Image("xmark")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(background())
        .onHover { (flag) in
            if flag {
                self.status.append(.hover)
            } else {
                self.status.removeAll { (status) -> Bool in
                    return status == .hover
                }
            }
        }
        .onTapGesture {
            if self.status.contains(.selected) {
                self.status.removeAll { (status) -> Bool in
                    return status == .selected
                }
            } else {
                self.status.append(.selected)
            }
        }
    }
    
    private func background() -> some View {
        if status.contains(.selected) {
            return blueGray0.opacity(0.3)
        } else {
            return touchAbleBlack
        }
    }
    
}

struct ProgressBar: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    
    init(value: Double,
         maxValue: Double,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = blueGray0.opacity(0.7),
         foregroundColor: Color = .primary) {
        self.value = value
        self.maxValue = maxValue
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        // 1
        ZStack {
            // 2
            GeometryReader { geometryReader in
                // 3
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor) // 4
                }
                
                Capsule()
                    .frame(width: self.progress(value: self.value,
                                                maxValue: self.maxValue,
                                                width: geometryReader.size.width)) // 5
                    .foregroundColor(self.foregroundColor) // 6
                //                    .animation(.easeIn) // 7
            }
        }
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct ProgressCircle: View {
    enum Stroke {
        case line
        case dotted
        
        func strokeStyle(lineWidth: CGFloat) -> StrokeStyle {
            switch self {
            case .line:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round)
            case .dotted:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round,
                                   dash: [12])
            }
        }
    }
    
    private let value: Double
    private let maxValue: Double
    private let style: Stroke
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let lineWidth: CGFloat
    
    init(value: Double,
         maxValue: Double,
         style: Stroke = .line,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = blueGray0.opacity(0.5),
         foregroundColor: Color = .primary,
         lineWidth: CGFloat = 3) {
        self.value = value
        self.maxValue = maxValue
        self.style = style
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            if self.backgroundEnabled {
                Circle()
                    .stroke(lineWidth: self.lineWidth)
                    .foregroundColor(self.backgroundColor)
            }
            
            Circle()
                .trim(from: 0, to: CGFloat(self.value / self.maxValue))
                .stroke(style: self.style.strokeStyle(lineWidth: self.lineWidth))
                .foregroundColor(self.foregroundColor)
                .rotationEffect(Angle(degrees: -90))
            //                .animation(.easeIn)
        }
    }
}


struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView()
    }
}
