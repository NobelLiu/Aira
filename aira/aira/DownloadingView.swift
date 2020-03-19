//
//  DownloadingView.swift
//  aira
//
//  Created by Nobel on 2020/3/17.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

struct DownloadingView: View {
    var body: some View {
        Group {
            //            VStack(alignment: .leading) {
            //                Text("Downloading")
            //                    .font(.headline)
            //                    .padding(.horizontal)
            //            }
            //            .frame(height: 37)
            //            Divider()
            HStack {
                ToolbarButton(AnyView(Image("plus")))
                    .onTapGesture {
                        print("add")
                }
                Spacer()
                ToolbarButton(AnyView(Image("pause")))
                //                    .opacity(0.5)
                ToolbarButton(AnyView(Image("stop")))
                //                    .opacity(0.5)
                ToolbarButton(AnyView(Image("xmark")))
                //                    .opacity(0.5)
            }.padding()
            //            .background(Color.white.opacity(0.01))
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<10) { index in
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

struct DownloadingView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingView()
    }
}
