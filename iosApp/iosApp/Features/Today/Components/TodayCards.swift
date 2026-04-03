//
//  TodayCards.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

struct ReportCardView: View {
    let report: TodayViewState.Report
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Label(report.kind, systemImage: "sun.haze.fill")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(TodayPalette.coral)

                    Spacer()

                    Text(report.time)
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(TodayPalette.secondaryInk)
                }

                Text(report.summary)
                    .font(.headline)
                    .foregroundStyle(TodayPalette.ink)
                    .multilineTextAlignment(.leading)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(report.highlights, id: \.self) { item in
                        HStack(alignment: .top, spacing: 8) {
                            Circle()
                                .fill(TodayPalette.blue.opacity(0.55))
                                .frame(width: 6, height: 6)
                                .padding(.top, 7)

                            Text(item)
                                .font(.footnote)
                                .foregroundStyle(TodayPalette.secondaryInk)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }

                Text("查看详情")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(TodayPalette.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(TodayCardBackground())
        }
        .buttonStyle(.plain)
    }
}

struct ModuleCardView: View {
    let module: TodayViewState.Module
    let onAction: (TodayAction) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                Image(systemName: module.symbol)
                    .font(.title3)
                    .foregroundStyle(module.tone.accent)
                    .frame(width: 42, height: 42)
                    .background(module.tone.accent.opacity(0.14), in: RoundedRectangle(cornerRadius: 14, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(module.title)
                        .font(.headline)
                        .foregroundStyle(TodayPalette.ink)

                    Text(module.subtitle)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(module.tone.accent)
                }

                Spacer(minLength: 0)
            }

            Text(module.detail)
                .font(.footnote)
                .foregroundStyle(TodayPalette.secondaryInk)
                .multilineTextAlignment(.leading)

            HStack(spacing: 10) {
                ForEach(module.actions) { action in
                    Button(action.title) {
                        onAction(.moduleQuickAction(moduleID: module.id, actionID: action.id))
                    }
                    .buttonStyle(
                        TodayCompactActionButtonStyle(
                            tint: module.tone.accent,
                            kind: action.prominence == .primary ? .primary : .secondary
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(TodayCardBackground())
        .contentShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .onTapGesture {
            onAction(.openModule(module.id))
        }
    }
}

struct SuggestionCardView: View {
    let suggestion: TodayViewState.Suggestion
    let onAction: (TodayAction) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(suggestion.title)
                .font(.headline)
                .foregroundStyle(TodayPalette.ink)

            Text(suggestion.reason)
                .font(.footnote)
                .foregroundStyle(TodayPalette.secondaryInk)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                Button(suggestion.actionTitle) {
                    onAction(.openSuggestion(suggestion.id))
                }
                .todaySecondaryButton(controlSize: .regular)

                Button("问问 AI") {
                    onAction(.askSuggestionAI(suggestion.id))
                }
                .todaySecondaryButton(controlSize: .regular)
            }
        }
        .padding(18)
        .background(TodayCardBackground())
    }
}

struct ExtensionCardView: View {
    let card: TodayViewState.ExtensionCard
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: card.symbol)
                    .font(.headline)
                    .foregroundStyle(TodayPalette.blue)
                    .frame(width: 36, height: 36)
                    .background(TodayPalette.blue.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                Text(card.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(TodayPalette.ink)

                Text(card.value)
                    .font(.headline)
                    .foregroundStyle(TodayPalette.ink)

                Text(card.detail)
                    .font(.footnote)
                    .foregroundStyle(TodayPalette.secondaryInk)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, minHeight: 160, alignment: .topLeading)
            .padding(16)
            .background(TodayCardBackground())
        }
        .buttonStyle(.plain)
    }
}
