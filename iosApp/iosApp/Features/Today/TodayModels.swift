//
//  TodayModels.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

enum TodayAction: Equatable {
    case openSettings
    case heroPrimary
    case heroSecondary
    case heroReason(String)
    case openReports
    case openReport(String)
    case openModule(String)
    case moduleQuickAction(moduleID: String, actionID: String)
    case openSuggestion(String)
    case askSuggestionAI(String)
    case openExtension(String)
}

struct TodayViewState {
    struct Header {
        let dateText: String
        let weekdayText: String
        let badgeText: String
        let avatarText: String
    }

    struct Banner {
        enum Tone {
            case normal
            case highlight
            case caution

            var color: Color {
                switch self {
                case .normal:
                    return TodayPalette.blue
                case .highlight:
                    return TodayPalette.gold
                case .caution:
                    return TodayPalette.coral
                }
            }

            var symbol: String {
                switch self {
                case .normal:
                    return "sparkles"
                case .highlight:
                    return "sun.max.fill"
                case .caution:
                    return "exclamationmark.circle.fill"
                }
            }
        }

        let title: String
        let message: String
        let tone: Tone
    }

    struct Hero {
        let title: String
        let summary: String
        let primaryTitle: String
        let secondaryTitle: String
        let reasons: [Reason]
    }

    struct Reason: Identifiable {
        let id: String
        let title: String
        let symbol: String
    }

    struct Report: Identifiable {
        let id: String
        let kind: String
        let time: String
        let summary: String
        let highlights: [String]
    }

    struct Module: Identifiable {
        enum Tone {
            case neutral
            case calm
            case warning

            var accent: Color {
                switch self {
                case .neutral:
                    return TodayPalette.blue
                case .calm:
                    return TodayPalette.green
                case .warning:
                    return TodayPalette.coral
                }
            }
        }

        let id: String
        let title: String
        let subtitle: String
        let detail: String
        let symbol: String
        let tone: Tone
        let actions: [QuickAction]
    }

    struct QuickAction: Identifiable {
        enum Prominence {
            case primary
            case secondary
        }

        let id: String
        let title: String
        let prominence: Prominence
    }

    struct Suggestion: Identifiable {
        let id: String
        let title: String
        let reason: String
        let actionTitle: String
    }

    struct ExtensionCard: Identifiable {
        let id: String
        let title: String
        let value: String
        let detail: String
        let symbol: String
    }

    let header: Header
    let banner: Banner?
    let hero: Hero
    let reports: [Report]
    let modules: [Module]
    let suggestions: [Suggestion]
    let extensions: [ExtensionCard]
}

extension TodayViewState {
    static let mock = TodayViewState(
        header: .init(
            dateText: "4月2日",
            weekdayText: "星期四",
            badgeText: "今天",
            avatarText: "FY"
        ),
        banner: .init(
            title: "午报已更新",
            message: "用半分钟看完重点，再决定下午要不要加速。",
            tone: .highlight
        ),
        hero: .init(
            title: "今天先把高专注任务放到上午",
            summary: "你的恢复状态还不错，但下午安排会更密一些。先把最需要完整注意力的事放在前面，今天会轻松很多。",
            primaryTitle: "查看今日计划",
            secondaryTitle: "问问 AI",
            reasons: [
                .init(id: "sleep", title: "睡眠 7.1h", symbol: "bed.double.fill"),
                .init(id: "calendar", title: "下午 3 项安排", symbol: "calendar"),
                .init(id: "exercise", title: "最近运动偏少", symbol: "figure.walk")
            ]
        ),
        reports: [
            .init(
                id: "midday-briefing",
                kind: "午报",
                time: "12:30",
                summary: "上午推进顺利，下午更适合把会议和沟通类事项集中处理。",
                highlights: [
                    "最重要任务已完成 60%",
                    "16:00 后日程更紧，适合提前留出缓冲",
                    "步数偏低，午后可以补一个短走动"
                ]
            )
        ],
        modules: [
            .init(
                id: "plan",
                title: "今日计划",
                subtitle: "2 / 5 已完成",
                detail: "下一项固定安排在 14:00，上午还剩 75 分钟深度工作窗口。",
                symbol: "checklist",
                tone: .neutral,
                actions: [
                    .init(id: "open-plan", title: "看计划", prominence: .primary),
                    .init(id: "adjust-plan", title: "调整安排", prominence: .secondary)
                ]
            ),
            .init(
                id: "health",
                title: "健康状态",
                subtitle: "恢复中等偏稳",
                detail: "昨晚睡眠基本够用，但连续两天活动量偏低，今天更适合穿插轻活动。",
                symbol: "heart.text.square",
                tone: .calm,
                actions: [
                    .init(id: "open-health", title: "看健康", prominence: .primary),
                    .init(id: "ask-health-ai", title: "让 AI 解释", prominence: .secondary)
                ]
            ),
            .init(
                id: "risk",
                title: "风险提醒",
                subtitle: "晚间可能偏拥挤",
                detail: "如果下午临时加任务，晚上容易出现恢复不足。现在更适合提前做取舍。",
                symbol: "exclamationmark.triangle",
                tone: .warning,
                actions: [
                    .init(id: "review-risk", title: "看详情", prominence: .primary),
                    .init(id: "trim-evening", title: "收紧晚间安排", prominence: .secondary)
                ]
            ),
            .init(
                id: "flexible",
                title: "灵活待办",
                subtitle: "现在最值得做 3 件事",
                detail: "先确认下午会议材料，再回复 2 条重要消息，最后补一个 10 分钟活动。",
                symbol: "square.stack.3d.up",
                tone: .neutral,
                actions: [
                    .init(id: "open-flexible", title: "查看待办", prominence: .primary),
                    .init(id: "delay-item", title: "延后一项", prominence: .secondary)
                ]
            )
        ],
        suggestions: [
            .init(
                id: "focus-block",
                title: "把需要完整思考的任务压缩到午饭前完成",
                reason: "下午沟通类事务更密，提前做完会减少来回切换。",
                actionTitle: "去看计划"
            ),
            .init(
                id: "walk-break",
                title: "下午开始前留一个 10 分钟走动缓冲",
                reason: "最近活动量偏低，这样更利于后半天维持专注。",
                actionTitle: "查看健康"
            ),
            .init(
                id: "evening-load",
                title: "今晚尽量只保留一件真正重要的事",
                reason: "今天整体密度偏高，减少额外安排更有助于恢复。",
                actionTitle: "让 AI 帮我取舍"
            )
        ],
        extensions: [
            .init(
                id: "news",
                title: "资讯",
                value: "3 条值得看",
                detail: "偏向科技和本地信息",
                symbol: "newspaper"
            ),
            .init(
                id: "focus",
                title: "专注度",
                value: "上午更佳",
                detail: "建议把难事继续放前面",
                symbol: "scope"
            )
        ]
    )
}
