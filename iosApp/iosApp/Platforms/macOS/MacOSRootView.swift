//
//  MacOSRootView.swift
//  iosApp
//
//  Created by 傅逸凡 on 2026/4/1.
//

import Shared
import SwiftUI

struct MacOSRootView: View {
    @State private var showContent = false
    var body: some View {
        VStack {
            Button("Click me!") {
                withAnimation {
                    showContent = !showContent
                }
            }

            if showContent {
                VStack(spacing: 16) {
                    Image(systemName: "swift")
                        .font(.system(size: 200))
                        .foregroundColor(.accentColor)
                    Text("SwiftUI on macOS: \(Greeting().greet())")
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct MacOSRootView_Previews: PreviewProvider {
    static var previews: some View {
        MacOSRootView()
    }
}
