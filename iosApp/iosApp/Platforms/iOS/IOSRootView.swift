//
//  IOSRootView.swift
//  iosApp
//
//  Created by 傅逸凡 on 2026/4/1.
//

import Shared
import SwiftUI
//import SwiftUIIntrospect

#Preview {
    IOSRootView()
}

struct IOSRootView: View {
    @State private var searchText = ""

    var body: some View {
        TabView {
            Tab(String(localized: "Today"), systemImage: "sun.max") {
                NavigationStack {
                    TodayView()
                }
            }

            Tab(String(localized: "Plan"), systemImage: "calendar") {
                NavigationStack {
//                    PlanView()
                }
            }

            Tab(String(localized: "Health"), systemImage: "heart") {
                NavigationStack {
//                    HealthView()
                }
            }

            Tab(String(localized: "Insight"), systemImage: "radicand.squareroot") {
                NavigationStack {
//                    InsightView()
                }
            }

            Tab(String(localized: "AI"), systemImage: "wand.and.sparkles", role: .search) {
                NavigationStack {
                    ChatView()
                        .searchable(text: $searchText, prompt: String(localized: "Let AI help you anything!"))
                }
            }
        }
    }
}
