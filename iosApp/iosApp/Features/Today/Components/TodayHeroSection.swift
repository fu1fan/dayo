//
//  TodayHeroSection.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

struct HeroCardView: View {
    let hero: TodayViewState.Hero
    let onAction: (TodayAction) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Label("今日建议", systemImage: "sparkles")
                .font(.caption.weight(.semibold))
                .foregroundStyle(TodayPalette.secondaryInk)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.white.opacity(0.5), in: Capsule())

            Text(hero.title)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(TodayPalette.ink)
                .fixedSize(horizontal: false, vertical: true)

            Text(hero.summary)
                .font(.body)
                .foregroundStyle(TodayPalette.secondaryInk)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 12) {
                Button(hero.primaryTitle) {
                    onAction(.heroPrimary)
                }
                .todayPrimaryButton()

                Button(hero.secondaryTitle) {
                    onAction(.heroSecondary)
                }
                .todaySecondaryButton()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(hero.reasons) { reason in
                        Button {
                            onAction(.heroReason(reason.id))
                        } label: {
                            Label(reason.title, systemImage: reason.symbol)
                                .font(.footnote.weight(.medium))
                                .foregroundStyle(TodayPalette.ink)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 9)
                                .background(.white.opacity(0.74), in: Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            TodayPalette.heroStart,
                            TodayPalette.heroEnd
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(.white.opacity(0.62), lineWidth: 1)
        )
        .shadow(color: TodayPalette.blue.opacity(0.12), radius: 20, y: 14)
    }
}
