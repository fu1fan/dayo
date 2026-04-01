//
//  IOSRootView.swift
//  iosApp
//
//  Created by 傅逸凡 on 2026/4/1.
//

import Shared
import SwiftUI

struct IOSRootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                Text("今日")
            }
            .tabItem {
                Label("今日", systemImage: "sun.max")
            }

            NavigationStack {
                Text("日程")
            }
            .tabItem {
                Label("日程", systemImage: "calendar")
            }

            NavigationStack {
                Text("我的")
            }
            .tabItem {
                Label("我的", systemImage: "person")
            }
        }
    }
}
