//
//  TodayView.swift
//  iosApp
//
//  Created by 傅逸凡 on 2026/4/2.
//

import SwiftUI

struct TodayView: View {
    let state: TodayViewState
    let onAction: (TodayAction) -> Void

    init(
        state: TodayViewState = .mock,
        onAction: @escaping (TodayAction) -> Void = { _ in }
    ) {
        self.state = state
        self.onAction = onAction
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            TodayGlassContainer(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    TodayTopBar(header: state.header) {
                        onAction(.openSettings)
                    }

                    if let banner = state.banner {
                        StatusBannerView(banner: banner)
                    }

                    HeroCardView(hero: state.hero, onAction: onAction)

                    if !state.reports.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            TodaySectionHeader(
                                title: "最新日报",
                                subtitle: "更新后会短暂置顶，读完后恢复默认排序"
                            ) {
                                onAction(.openReports)
                            }

                            ForEach(state.reports) { report in
                                ReportCardView(report: report) {
                                    onAction(.openReport(report.id))
                                }
                            }
                        }
                    }

                    if !state.modules.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            TodaySectionHeader(
                                title: "今日重点",
                                subtitle: "把最需要处理的内容放在今天的前半屏"
                            )

                            ForEach(state.modules) { module in
                                ModuleCardView(module: module, onAction: onAction)
                            }
                        }
                    }

                    if !state.suggestions.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            TodaySectionHeader(
                                title: "综合建议",
                                subtitle: "结合计划、恢复状态和节奏给出下一步提示"
                            )

                            ForEach(state.suggestions) { suggestion in
                                SuggestionCardView(suggestion: suggestion, onAction: onAction)
                            }
                        }
                    }

                    if !state.extensions.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            TodaySectionHeader(
                                title: "扩展信息",
                                subtitle: "补充信息放在靠后位置，不抢主建议的注意力"
                            )

                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 14),
                                    GridItem(.flexible(), spacing: 14)
                                ],
                                spacing: 14
                            ) {
                                ForEach(state.extensions) { card in
                                    ExtensionCardView(card: card) {
                                        onAction(.openExtension(card.id))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background {
            TodayBackground()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        TodayView()
    }
}
