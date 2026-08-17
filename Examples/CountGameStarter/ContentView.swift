import SwiftUI
import GameEffects

/// 「0 にした人が負け」の数取りゲームの完成例です。
struct ContentView: View {
    @State private var count = 17
    @State private var result = ""
    @State private var isRedTurn = true
    @State private var redSpecialUsed = false
    @State private var blueSpecialUsed = false

    // 数字や演出をもう一度動かすための、見えない合図です。
    @State private var countEffectID = 0
    @State private var specialEffectID = 0
    @State private var gameOverEffectID = 0

    private var isGameOver: Bool {
        !result.isEmpty
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                playerArea(isRed: false)

                countCard

                playerArea(isRed: true)
            }

            GameOverEffect(trigger: gameOverEffectID)
                .allowsHitTesting(false)

            if isGameOver {
                Button("もう一度あそぶ", action: resetGame)
                    .font(.headline.bold())
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .padding(.top, 210)
                    .accessibilityHint("17から新しいゲームを始めます")
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .specialEffect(trigger: specialEffectID)
    }

    private var countCard: some View {
        VStack(spacing: 8) {
            Text(isGameOver ? result : "残りの数")
                .font(.headline)
                .foregroundStyle(isGameOver ? .red : .secondary)

            Text("\(count)")
                .font(.system(size: 64, weight: .black, design: .rounded))
                .contentTransition(.numericText())
                .accessibilityLabel("残り \(count)")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(.thinMaterial)
        .gameCountEffect(trigger: countEffectID)
        .accessibilityElement(children: .combine)
    }

    private func playerArea(isRed: Bool) -> some View {
        let playerName = isRed ? "赤" : "青"
        let color: Color = isRed ? .red : .blue
        let isCurrentTurn = isRed == isRedTurn

        return VStack(spacing: 12) {
            HStack {
                Label("\(playerName)の番", systemImage: isCurrentTurn ? "hand.point.right.fill" : "hourglass")
                    .font(.title3.weight(.bold))

                Spacer()

                Text(isCurrentTurn && !isGameOver ? "えらんでね" : "待ってね")
                    .font(.subheadline.weight(.semibold))
            }
            .foregroundStyle(.white)

            HStack(spacing: 10) {
                moveButton(amount: 1, playerName: playerName, color: color, isRed: isRed)
                moveButton(amount: 2, playerName: playerName, color: color, isRed: isRed)
                moveButton(amount: 3, playerName: playerName, color: color, isRed: isRed)
                specialButton(playerName: playerName, isRed: isRed)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
        .background(color.gradient)
        .opacity(isCurrentTurn || isGameOver ? 1 : 0.62)
        .animation(.easeInOut(duration: 0.2), value: isRedTurn)
    }

    private func moveButton(amount: Int, playerName: String, color: Color, isRed: Bool) -> some View {
        Button {
            take(amount, forRed: isRed, isSpecial: false)
        } label: {
            VStack(spacing: 3) {
                Text("\(amount)")
                    .font(.title.weight(.black))
                Text("とる")
                    .font(.caption.weight(.bold))
            }
            .frame(maxWidth: .infinity, minHeight: 68)
        }
        .buttonStyle(MoveButtonStyle(color: color))
        .disabled(!canTake(amount, forRed: isRed))
        .accessibilityLabel("\(playerName)が \(amount) つ取る")
        .accessibilityHint("残りの数を \(amount) 減らして、相手の番にします")
    }

    private func specialButton(playerName: String, isRed: Bool) -> some View {
        let alreadyUsed = isRed ? redSpecialUsed : blueSpecialUsed

        return Button {
            take(5, forRed: isRed, isSpecial: true)
        } label: {
            VStack(spacing: 3) {
                Image(systemName: alreadyUsed ? "checkmark" : "bolt.fill")
                    .font(.title3.weight(.black))
                Text(alreadyUsed ? "使用済み" : "5 とる")
                    .font(.caption.weight(.bold))
            }
            .frame(maxWidth: .infinity, minHeight: 68)
        }
        .buttonStyle(SpecialMoveButtonStyle())
        .disabled(alreadyUsed || !canTake(5, forRed: isRed))
        .accessibilityLabel(alreadyUsed ? "\(playerName)のスペシャルは使用済み" : "\(playerName)がスペシャルで 5 つ取る")
        .accessibilityHint("1ゲームに1回だけ使えます")
    }

    private func canTake(_ amount: Int, forRed: Bool) -> Bool {
        !isGameOver && isRed == isRedTurn && count >= amount
    }

    private func take(_ amount: Int, forRed: Bool, isSpecial: Bool) {
        guard canTake(amount, forRed: forRed) else { return }

        withAnimation(.spring(response: 0.3, dampingFraction: 0.55)) {
            count -= amount
            countEffectID += 1

            if isSpecial {
                if forRed {
                    redSpecialUsed = true
                } else {
                    blueSpecialUsed = true
                }
                specialEffectID += 1
            }

            if count == 0 {
                result = forRed ? "赤の負け！" : "青の負け！"
                gameOverEffectID += 1
            } else {
                isRedTurn.toggle()
            }
        }

        GameSound.play(isSpecial ? .special : .take)
        GameFeedback.trigger(isSpecial ? .special : .take)

        if isGameOver {
            GameSound.play(.gameOver)
            GameFeedback.trigger(.gameOver)
        }
    }

    private func resetGame() {
        withAnimation(.spring) {
            count = 17
            result = ""
            isRedTurn = true
            redSpecialUsed = false
            blueSpecialUsed = false
            countEffectID += 1
        }
    }
}

private struct MoveButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(color)
            .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(configuration.isPressed ? 0 : 0.18), radius: 5, y: 4)
            .scaleEffect(configuration.isPressed ? 0.93 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

private struct SpecialMoveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .background(.yellow.gradient, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(.white, lineWidth: 2)
            }
            .shadow(color: .black.opacity(configuration.isPressed ? 0 : 0.24), radius: 5, y: 4)
            .scaleEffect(configuration.isPressed ? 0.93 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
