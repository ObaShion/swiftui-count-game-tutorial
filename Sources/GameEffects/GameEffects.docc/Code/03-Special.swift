import SwiftUI

struct ContentView: View {
    @State private var count = 17
    @State private var result = ""
    @State private var playerTurn = true
    @State private var redSpecialUsed = false
    @State private var blueSpecialUsed = false

    var body: some View {
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
    }

    private var countCard: some View {
        VStack(spacing: 4) {
            Text(result == "" ? "残りの数" : result)
                .font(.headline)
                .foregroundStyle(result == "" ? Color.secondary : Color.red)
            Text("\(count)")
                .font(.system(size: 64, weight: .black, design: .rounded))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(.white)
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

            if isSpecial {
                if isBlue {
                    blueSpecialUsed = true
                } else {
                    redSpecialUsed = true
                }
            }

            if count == 0 {
                result = isBlue ? "青の負け！" : "赤の負け！"
            } else {
                playerTurn = isBlue
            }
        }
    }
}

#Preview {
    ContentView()
}
