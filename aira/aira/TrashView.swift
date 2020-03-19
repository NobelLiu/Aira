//
//  TrashView.swift
//  aira
//
//  Created by Nobel on 2020/3/17.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

struct TrashView: View {
    var body: some View {
        Group {
            HStack {
                Spacer()
                ToolbarButton(AnyView(Image("arrow.clockwise")))
                    .opacity(0.5)
                ToolbarButton(AnyView(
                    HStack(spacing: 0) {
                        Image("broom")
                        Text("2")
                            .font(.system(size: 18))
                            .frame(minWidth: 21)
                    }
                ))
            }.padding()
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<1) { index in
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

struct TrashView_Previews: PreviewProvider {
    static var previews: some View {
        TrashView()
    }
}
