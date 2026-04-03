//
//  TodaySectionHeader.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

struct TodaySectionHeader: View {
    let title: String
    let subtitle: String
    var action: (() -> Void)?

    init(title: String, subtitle: String, action: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(TodayPalette.ink)

                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(TodayPalette.secondaryInk)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            if let action {
                Button("查看全部", action: action)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(TodayPalette.blue)
                    .buttonStyle(.plain)
            }
        }
    }
}
