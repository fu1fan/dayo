//
//  TodayTheme.swift
//  iosApp
//
//  Created by Codex on 2026/4/3.
//

import SwiftUI

struct TodayGlassContainer<Content: View>: View {
    let spacing: CGFloat?
    @ViewBuilder let content: () -> Content

    init(
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            GlassEffectContainer(spacing: spacing, content: content)
        } else {
            content()
        }
    }
}

struct TodayBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    TodayPalette.canvasTop,
                    TodayPalette.canvasBottom
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(TodayPalette.sun.opacity(0.16))
                .frame(width: 260)
                .blur(radius: 10)
                .offset(x: 150, y: -280)

            Circle()
                .fill(TodayPalette.blue.opacity(0.12))
                .frame(width: 240)
                .blur(radius: 10)
                .offset(x: -170, y: 130)
        }
    }
}

struct TodayCardBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    private let cornerRadius: CGFloat = 26

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        ZStack {
            if #available(iOS 26.0, *) {
                Color.clear
                    .glassEffect(
                        .regular
                            .tint(TodayPalette.glassTint)
                            .interactive(false),
                        in: shape
                    )
            } else {
                shape.fill(.regularMaterial)
            }
        }
        .overlay(
            shape.stroke(TodayPalette.cardStroke, lineWidth: 1)
        )
        .shadow(
            color: TodayPalette.shadow.opacity(colorScheme == .dark ? 0.14 : 0.08),
            radius: colorScheme == .dark ? 14 : 20,
            y: colorScheme == .dark ? 8 : 12
        )
    }
}

struct TodayPrimaryButtonModifier: ViewModifier {
    let tint: Color
    let controlSize: ControlSize

    @ViewBuilder
    func body(content: Content) -> some View {
        let configured = content
            .font(.subheadline.weight(.semibold))
            .tint(tint)
            .controlSize(controlSize)

        if #available(iOS 26.0, *) {
            configured.buttonStyle(.glassProminent)
        } else {
            configured.buttonStyle(.borderedProminent)
        }
    }
}

struct TodaySecondaryButtonModifier: ViewModifier {
    let tint: Color
    let controlSize: ControlSize

    @ViewBuilder
    func body(content: Content) -> some View {
        let configured = content
            .font(.subheadline.weight(.semibold))
            .tint(tint)
            .controlSize(controlSize)

        if #available(iOS 26.0, *) {
            configured.buttonStyle(.glass)
        } else {
            configured.buttonStyle(.bordered)
        }
    }
}

extension View {
    func todayPrimaryButton(
        tint: Color = TodayPalette.primaryAccent,
        controlSize: ControlSize = .large
    ) -> some View {
        modifier(TodayPrimaryButtonModifier(tint: tint, controlSize: controlSize))
    }

    func todaySecondaryButton(
        tint: Color = TodayPalette.blue,
        controlSize: ControlSize = .large
    ) -> some View {
        modifier(TodaySecondaryButtonModifier(tint: tint, controlSize: controlSize))
    }
}

struct TodayCompactActionButtonStyle: ButtonStyle {
    enum Kind {
        case primary
        case secondary
    }

    let tint: Color
    let kind: Kind

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.footnote.weight(.semibold))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(background(configuration: configuration))
            .overlay {
                Capsule()
                    .stroke(borderColor(configuration: configuration), lineWidth: 1)
            }
            .contentShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }

    private var foregroundColor: Color {
        switch kind {
        case .primary:
            return .white
        case .secondary:
            return tint
        }
    }

    @ViewBuilder
    private func background(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed

        switch kind {
        case .primary:
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            tint.opacity(pressed ? 0.78 : 0.92),
                            tint.opacity(pressed ? 0.64 : 0.78)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        case .secondary:
            Capsule()
                .fill(.thinMaterial)
                .overlay {
                    Capsule()
                        .fill(tint.opacity(pressed ? 0.14 : 0.08))
                }
        }
    }

    private func borderColor(configuration: Configuration) -> Color {
        switch kind {
        case .primary:
            return tint.opacity(configuration.isPressed ? 0.30 : 0.18)
        case .secondary:
            return tint.opacity(configuration.isPressed ? 0.24 : 0.16)
        }
    }
}

enum TodayPalette {
    static let canvasTop = dynamicColor(
        light: UIColor(red: 0.99, green: 0.96, blue: 0.92, alpha: 1),
        dark: UIColor(red: 0.08, green: 0.10, blue: 0.13, alpha: 1)
    )
    static let canvasBottom = dynamicColor(
        light: UIColor(red: 0.94, green: 0.97, blue: 0.99, alpha: 1),
        dark: UIColor(red: 0.10, green: 0.13, blue: 0.17, alpha: 1)
    )
    static let heroStart = dynamicColor(
        light: UIColor(red: 1.00, green: 0.92, blue: 0.82, alpha: 1),
        dark: UIColor(red: 0.31, green: 0.25, blue: 0.20, alpha: 1)
    )
    static let heroEnd = dynamicColor(
        light: UIColor(red: 0.87, green: 0.92, blue: 1.00, alpha: 1),
        dark: UIColor(red: 0.18, green: 0.24, blue: 0.31, alpha: 1)
    )
    static let ink = dynamicColor(
        light: UIColor(red: 0.17, green: 0.20, blue: 0.27, alpha: 1),
        dark: UIColor(red: 0.93, green: 0.95, blue: 0.98, alpha: 1)
    )
    static let secondaryInk = dynamicColor(
        light: UIColor(red: 0.37, green: 0.41, blue: 0.49, alpha: 1),
        dark: UIColor(red: 0.69, green: 0.73, blue: 0.80, alpha: 1)
    )
    static let blue = dynamicColor(
        light: UIColor(red: 0.35, green: 0.53, blue: 0.87, alpha: 1),
        dark: UIColor(red: 0.55, green: 0.72, blue: 1.00, alpha: 1)
    )
    static let green = dynamicColor(
        light: UIColor(red: 0.25, green: 0.63, blue: 0.50, alpha: 1),
        dark: UIColor(red: 0.46, green: 0.82, blue: 0.67, alpha: 1)
    )
    static let coral = dynamicColor(
        light: UIColor(red: 0.89, green: 0.47, blue: 0.40, alpha: 1),
        dark: UIColor(red: 1.00, green: 0.62, blue: 0.55, alpha: 1)
    )
    static let gold = dynamicColor(
        light: UIColor(red: 0.85, green: 0.64, blue: 0.25, alpha: 1),
        dark: UIColor(red: 0.96, green: 0.78, blue: 0.40, alpha: 1)
    )
    static let sun = dynamicColor(
        light: UIColor(red: 0.98, green: 0.78, blue: 0.38, alpha: 1),
        dark: UIColor(red: 0.92, green: 0.70, blue: 0.34, alpha: 1)
    )
    static let cardBase = dynamicColor(
        light: UIColor.white.withAlphaComponent(0.28),
        dark: UIColor.white.withAlphaComponent(0.07)
    )
    static let cardStroke = dynamicColor(
        light: UIColor.white.withAlphaComponent(0.46),
        dark: UIColor.white.withAlphaComponent(0.10)
    )
    static let glassTint = dynamicColor(
        light: UIColor(red: 0.97, green: 0.98, blue: 1.00, alpha: 1),
        dark: UIColor(red: 0.17, green: 0.21, blue: 0.28, alpha: 1)
    )
    static let primaryAccent = dynamicColor(
        light: UIColor(red: 0.18, green: 0.22, blue: 0.30, alpha: 1),
        dark: UIColor(red: 0.30, green: 0.38, blue: 0.52, alpha: 1)
    )
    static let shadow = dynamicColor(
        light: UIColor.black,
        dark: UIColor.black
    )
}

private extension TodayPalette {
    static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        Color(
            uiColor: UIColor { trait in
                trait.userInterfaceStyle == .dark ? dark : light
            }
        )
    }
}
