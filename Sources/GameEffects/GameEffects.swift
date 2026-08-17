import SwiftUI

#if canImport(AudioToolbox)
import AudioToolbox
#endif

#if canImport(UIKit)
import UIKit
#endif

/// A kind of action in the number-taking game.
///
/// Use the same value with ``GameSound/play(_:)`` and
/// ``GameFeedback/trigger(_:)``.
public enum GameEffect: Sendable {
    case take
    case special
    case gameOver
}

/// Plays small built-in system sounds. No sound files need to be added to an app.
public enum GameSound {
    /// Plays the sound that matches a game action when the device supports it.
    public static func play(_ effect: GameEffect) {
        #if canImport(AudioToolbox)
        let soundID: SystemSoundID
        switch effect {
        case .take:
            soundID = 1104
        case .special:
            soundID = 1025
        case .gameOver:
            soundID = 1005
        }
        AudioServicesPlaySystemSound(soundID)
        #endif
    }
}

/// Triggers optional haptic feedback on iPhone. It quietly does nothing elsewhere.
public enum GameFeedback {
    /// Triggers the feedback that matches a game action when haptics are available.
    public static func trigger(_ effect: GameEffect) {
        #if canImport(UIKit)
        DispatchQueue.main.async {
            switch effect {
            case .take:
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            case .special:
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            case .gameOver:
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }
        #endif
    }
}

public extension View {
    /// Makes a view bounce briefly whenever `trigger` changes.
    ///
    /// Pass an integer that you increase after a player takes a number.
    func gameCountEffect(trigger: Int) -> some View {
        modifier(CountBounceModifier(trigger: trigger))
    }

    /// Shakes and flashes a view whenever `trigger` changes.
    ///
    /// Pass an integer that you increase after a player uses a special action.
    func specialEffect(trigger: Int) -> some View {
        modifier(SpecialActionModifier(trigger: trigger))
    }
}

private struct CountBounceModifier: ViewModifier {
    let trigger: Int
    @State private var isBouncing = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isBouncing ? 1.18 : 1)
            .animation(.bouncy(duration: 0.35, extraBounce: 0.28), value: isBouncing)
            .onChange(of: trigger) { _, _ in
                isBouncing = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                    isBouncing = false
                }
            }
    }
}

private struct SpecialActionModifier: ViewModifier {
    let trigger: Int
    @State private var isActive = false

    func body(content: Content) -> some View {
        content
            .overlay {
                Color.yellow.opacity(isActive ? 0.35 : 0)
                    .allowsHitTesting(false)
            }
            .offset(x: isActive ? 9 : 0)
            .animation(.easeInOut(duration: 0.07).repeatCount(5, autoreverses: true), value: isActive)
            .onChange(of: trigger) { _, _ in
                isActive = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                    isActive = false
                }
            }
    }
}

/// A lightweight confetti overlay for the end of a game.
///
/// Place it in a `ZStack` and increase `trigger` when the game ends.
public struct GameOverEffect: View {
    private let trigger: Int

    /// Creates an end-of-game effect. It is invisible until `trigger` is greater than zero.
    public init(trigger: Int) {
        self.trigger = trigger
    }

    public var body: some View {
        GeometryReader { _ in
            if trigger > 0 {
                Canvas { context, size in
                    let colors: [Color] = [.red, .blue, .yellow, .green, .purple, .orange]
                    for index in 0..<36 {
                        let x = pseudoRandom(index, trigger, modulus: 1000) / 1000 * size.width
                        let y = pseudoRandom(index + 53, trigger, modulus: 1000) / 1000 * size.height
                        let width = 7 + pseudoRandom(index + 17, trigger, modulus: 7)
                        let height = 10 + pseudoRandom(index + 31, trigger, modulus: 10)
                        let rect = CGRect(x: x, y: y, width: width, height: height)
                        context.fill(Path(ellipseIn: rect), with: .color(colors[index % colors.count]))
                    }
                }
                .transition(.opacity)
                .accessibilityHidden(true)
            }
        }
        .allowsHitTesting(false)
        .animation(.easeInOut(duration: 0.25), value: trigger)
    }

    private func pseudoRandom(_ index: Int, _ seed: Int, modulus: CGFloat) -> CGFloat {
        let value = (index &* 1103515245 &+ seed &* 12345) & 0x7fffffff
        return CGFloat(value).truncatingRemainder(dividingBy: modulus)
    }
}
