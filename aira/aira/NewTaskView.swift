//
//  NewTaskView.swift
//  aira
//
//  Created by Nobel on 2020/3/19.
//  Copyright © 2020 Nobel. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
    @State var link = ""
    @State var isProConfig = false
    @State var path = "/Users/nobel/Downloads"
    @State var threads = "5"
    var onClose: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("New")
                .font(.largeTitle)
            TextField("Link paste here", text: $link)
                .frame(minHeight: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                VStack(alignment: .leading) {
                    Text("Path")
                        .font(.subheadline)
                    TextField("Path", text: $path)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                VStack(alignment: .leading) {
                    Text("Threads")
                        .font(.subheadline)
                    Stepper(onIncrement: {
                        
                    }, onDecrement: {
                        
                    }) {
                        TextField("Number of threads", text: $threads)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .frame(width: 100)
                }
            }
            Spacer()
            Divider()
            HStack {
                ToolbarButton(AnyView(Text("Select Torrent")), style: .outlineBorder)
                    .onTapGesture {
                }
                Spacer()
                ToolbarButton(AnyView(Text("Cancel")), style: .plain)
                    .onTapGesture {
                        if let block = self.onClose {
                            block()
                        }
                }
                ToolbarButton(AnyView(Text("Download")))
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [blueGray1, blueGray2]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .frame(width: 400, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
        .shadow(radius: 6)
        .edgesIgnoringSafeArea(.all)
    }
    
    init(onClose: (() -> Void)? = nil) {
        self.onClose = onClose
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
