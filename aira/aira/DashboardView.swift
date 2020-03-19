//
//  DashboardView.swift
//  aira
//
//  Created by Nobel on 2020/3/17.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

enum Tab: Int {
    case downloading, history, trash
    
    var icon: String {
        switch self {
        case .downloading:
            return "arrow.down.circle"
        case .history:
            return "clock"
        case .trash:
            return "trash"
        }
    }
    
    var fillIcon: String {
        switch self {
        case .downloading:
            return "arrow.down.circle.fill"
        case .history:
            return "clock.fill"
        case .trash:
            return "trash.fill"
        }
    }
}

let blueGray0 = Color(red: 94 / 255, green: 102 / 255, blue: 114 / 255)
let blueGray1 = Color(red: 64 / 255, green: 73 / 255, blue: 83 / 255)
let blueGray2 = Color(red: 37 / 255, green: 39 / 255, blue: 44 / 255)
let touchAbleBlack = Color.black.opacity(0.01)
let grayLinearGradient = LinearGradient(gradient: Gradient(colors: [blueGray1, blueGray2]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct DashboardView: View {
    
    @State private var tabs: [Tab] = [.downloading, .history, .trash]
    @State private var selectedTab = Tab.downloading
    @State var isShowNewTaskView = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ZStack {
                    VerticalTabBarView(icons: $tabs, selected: $selectedTab)
                    VStack(spacing: 0) {
                        Spacer()
                        Image("gear")
                            .foregroundColor(.secondary)
                            .padding()
                            .onTapGesture {
                                self.isShowNewTaskView.toggle()
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .frame(width: 78)
                Divider()
                    .edgesIgnoringSafeArea(.top)
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        if selectedTab == .downloading {
                            DownloadingView()
                        } else if selectedTab == .history {
                            HistoryView()
                        } else if selectedTab == .trash {
                            TrashView()
                        }
                    }
                    .background(Color.white.opacity(0.01))
                    Divider()
                    HStack {
                        //                    Image("speedometer")
                        //                    .scaledToFit()
                        Text("Totoal: 3 downloading task, 3.5 MB/s")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .frame(height: 34)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(grayLinearGradient)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
            }
            if isShowNewTaskView {
                NewTaskView {
                    self.isShowNewTaskView.toggle()
                }
            }
        }
    }
}

struct VerticalTabBarView: View {
    
    @Binding var icons: [Tab]
    @Binding var selected: Tab
    
    private func tabBarButton(icon image: String, color: Color) -> some View {
        return Image(image)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, minHeight: 44)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(icons, id: \.rawValue) { tab in
                self.tabBarButton(icon: self.selected == tab ? tab.fillIcon : tab.icon, color: self.selected == tab ? .primary : .secondary)
                    .background(self.selected == tab ? blueGray0.opacity(0.3) : touchAbleBlack)
                    .onTapGesture {
                        self.selected = tab
                }
            }
        }
    }
}

struct ToolbarButton: View {
    
    enum Style {
        case `default`, outlineBorder, plain
    }
    
    var content: AnyView
    var style: Style
    
    var body: some View {HStack {
        HStack {
            content.padding(.horizontal)
        }
        .frame(minWidth: 50, minHeight: 30)
        .background(style == .default ? AnyView(LinearGradient(gradient: Gradient(colors: [blueGray0, blueGray0.opacity(0.3)]), startPoint: .top, endPoint: .bottom)) : AnyView(touchAbleBlack))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(style == .outlineBorder ? Color.primary.opacity(0.5) : Color.clear, lineWidth: style == .outlineBorder ? 1.5 : 0)
        )
            .shadow(color: style == .default ? blueGray2.opacity(0.5) : Color.clear, radius: 0.6, x: 0, y: 1)
        }
    }
    
    init(_ content: AnyView, style: Style = .default) {
        self.content = content
        self.style = style
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
