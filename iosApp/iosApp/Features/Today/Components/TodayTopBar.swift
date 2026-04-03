//
//  TodayTopBar.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

struct TodayTopBar: View {
    let header: TodayViewState.Header
    let onSettingsTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(header.dateText)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(TodayPalette.ink)

                HStack(spacing: 8) {
                    Text(header.weekdayText)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(TodayPalette.secondaryInk)

                    Text(header.badgeText)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(TodayPalette.ink)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(TodayPalette.sun.opacity(0.24), in: Capsule())
                }
            }

            Spacer()

            Button(action: onSettingsTap) {
                Text(header.avatarText)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(TodayPalette.ink)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [TodayPalette.sun.opacity(0.9), TodayPalette.blue.opacity(0.55)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.65), lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel("打开设置")
        }
    }
}

struct StatusBannerView: View {
    let banner: TodayViewState.Banner

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: banner.tone.symbol)
                .font(.headline)
                .foregroundStyle(banner.tone.color)
                .padding(10)
                .background(banner.tone.color.opacity(0.14), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(banner.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(TodayPalette.ink)

                Text(banner.message)
                    .font(.footnote)
                    .foregroundStyle(TodayPalette.secondaryInk)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.white.opacity(0.72))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.white.opacity(0.72), lineWidth: 1)
        )
    }
}
