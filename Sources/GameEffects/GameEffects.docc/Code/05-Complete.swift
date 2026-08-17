import SwiftUI
import GameEffects

struct ContentView: View {
    @State private var count = 17
    @State private var result = ""
    @State private var playerTurn = true
    @State private var redSpecialUsed = false
    @State private var blueSpecialUsed = false
    @State private var countEffectTrigger = 0
    @State private var specialEffectTrigger = 0
    @State private var gameOverEffectTrigger = 0

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
            // 上半分：青
            VStack(spacing: 18) {
                turnLabel(name: "青", isCurrent: playerTurn == false)

                HStack(spacing: 8) {
                    Button { take(1, isBlue: true) } label: { moveLabel(1, color: .blue) }
                        .disabled(playerTurn == true || count < 1 || result != "")
                    Button { take(2, isBlue: true) } label: { moveLabel(2, color: .blue) }
                        .disabled(playerTurn == true || count < 2 || result != "")
                    Button { take(3, isBlue: true) } label: { moveLabel(3, color: .blue) }
                        .disabled(playerTurn == true || count < 3 || result != "")
                    Button {
                        take(5, isBlue: true, isSpecial: true)
                    } label: {
                        specialLabel(isUsed: blueSpecialUsed)
                    }
                    .disabled(playerTurn == true || count < 5 || blueSpecialUsed || result != "")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .background(.blue.gradient)
            .opacity(playerTurn == false || result != "" ? 1 : 0.62)

            countCard

            // 下半分：赤
            VStack(spacing: 18) {
                HStack(spacing: 8) {
                    Button { take(1, isBlue: false) } label: { moveLabel(1, color: .red) }
                        .disabled(playerTurn == false || count < 1 || result != "")
                    Button { take(2, isBlue: false) } label: { moveLabel(2, color: .red) }
                        .disabled(playerTurn == false || count < 2 || result != "")
                    Button { take(3, isBlue: false) } label: { moveLabel(3, color: .red) }
                        .disabled(playerTurn == false || count < 3 || result != "")
                    Button {
                        take(5, isBlue: false, isSpecial: true)
                    } label: {
                        specialLabel(isUsed: redSpecialUsed)
                    }
                    .disabled(playerTurn == false || count < 5 || redSpecialUsed || result != "")
                }

                turnLabel(name: "赤", isCurrent: playerTurn)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .background(.red.gradient)
            .opacity(playerTurn || result != "" ? 1 : 0.62)
            }
            .ignoresSafeArea(edges: .bottom)
            .animation(.easeInOut(duration: 0.2), value: playerTurn)

            GameOverEffect(trigger: gameOverEffectTrigger)
                .allowsHitTesting(false)

            if result != "" {
                Button("もう一度あそぶ！", action: resetGame)
                    .font(.headline.bold())
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .padding(.top, 210)
                    .accessibilityHint("17から新しいゲームを始めるよ")
            }
        }
        .specialEffect(trigger: specialEffectTrigger)
    }

    private var countCard: some View {
        VStack(spacing: 4) {
            Text(result == "" ? "残りの数" : result)
                .font(.headline)
                .foregroundStyle(result == "" ? Color.secondary : Color.red)
            Text("\(count)")
                .font(.system(size: 64, weight: .black, design: .rounded))
                .contentTransition(.numericText())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(.white)
        .gameCountEffect(trigger: countEffectTrigger)
    }

    private func turnLabel(name: String, isCurrent: Bool) -> some View {
        HStack {
            Label("\(name)の番！", systemImage: isCurrent ? "hand.point.right.fill" : "hourglass")
                .font(.title3.bold())
            Spacer()
            Text(isCurrent && result == "" ? "えらんでね！" : "待っててね")
                .font(.subheadline.bold())
        }
        .foregroundStyle(.white)
    }

    private func moveLabel(_ amount: Int, color: Color) -> some View {
        VStack(spacing: 2) {
            Text("\(amount)").font(.title.bold())
            Text("とる").font(.caption.bold())
        }
        .foregroundStyle(color)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.18), radius: 4, y: 3)
    }

    private func specialLabel(isUsed: Bool) -> some View {
        VStack(spacing: 2) {
            Image(systemName: isUsed ? "checkmark" : "bolt.fill")
                .font(.title3.bold())
            Text(isUsed ? "使用済み" : "5とる")
                .font(.caption.bold())
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(.yellow.gradient, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.22), radius: 4, y: 3)
    }

    private func take(_ amount: Int, isBlue: Bool, isSpecial: Bool = false) {
        guard count >= amount, result == "" else { return }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
            count -= amount
            countEffectTrigger += 1

            if isSpecial {
                if isBlue {
                    blueSpecialUsed = true
                } else {
                    redSpecialUsed = true
                }
                specialEffectTrigger += 1
            }

            if count == 0 {
                result = isBlue ? "青の負け！" : "赤の負け！"
                gameOverEffectTrigger += 1
            } else {
                playerTurn = isBlue
            }
        }

        GameSound.play(isSpecial ? .special : .take)
        GameFeedback.trigger(isSpecial ? .special : .take)

        if result != "" {
            GameSound.play(.gameOver)
            GameFeedback.trigger(.gameOver)
        }
    }

    private func resetGame() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            count = 17
            result = ""
            playerTurn = true
            redSpecialUsed = false
            blueSpecialUsed = false
            countEffectTrigger += 1
        }
    }
}

#Preview("赤の番") {
    ContentView()
}

#Preview("青の番") {
    ContentView(previewCount: 12, previewPlayerTurn: false)
}

#Preview("ゲーム終了") {
    ContentView(
        previewCount: 0,
        previewResult: "赤の負け！",
        previewPlayerTurn: true,
        previewRedSpecialUsed: true,
        previewGameOverEffectTrigger: 1
    )
}

extension ContentView {
    init(
        previewCount: Int,
        previewResult: String = "",
        previewPlayerTurn: Bool,
        previewRedSpecialUsed: Bool = false,
        previewBlueSpecialUsed: Bool = false,
        previewGameOverEffectTrigger: Int = 0
    ) {
        _count = State(initialValue: previewCount)
        _result = State(initialValue: previewResult)
        _playerTurn = State(initialValue: previewPlayerTurn)
        _redSpecialUsed = State(initialValue: previewRedSpecialUsed)
        _blueSpecialUsed = State(initialValue: previewBlueSpecialUsed)
        _gameOverEffectTrigger = State(initialValue: previewGameOverEffectTrigger)
    }
}
