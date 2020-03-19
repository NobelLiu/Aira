//
//  HistoryView.swift
//  aira
//
//  Created by Nobel on 2020/3/17.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        Group {
            HStack {
                Spacer()
                ToolbarButton(AnyView(Image("arrow.clockwise")))
                    .opacity(0.5)
                ToolbarButton(AnyView(Image("trash")))
                    .opacity(0.5)
            }.padding()
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<3) { index in
                        TaskCellView()
                        Divider()
                    }
                    TaskCellView()
                }
            }
            .frame(minWidth: 560, maxWidth: 800, minHeight: 320, maxHeight: .infinity)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
