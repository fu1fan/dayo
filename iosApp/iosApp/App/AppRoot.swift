//
//  AppRoot.swift
//  iosApp
//
//  Created by 傅逸凡 on 2026/4/1.
//
import SwiftUI

struct AppRoot: View {
    var body: some View {
        #if os(macOS)
        MacOSRootView()
        #else
        IOSRootView()
        #endif
    }
}
