import SwiftUI

struct ContentView: View {
    @State private var count = 17
    @State private var result = ""
    @State private var playerTurn = true

    var body: some View {
        VStack(spacing: 0) {
            // 上半分：青
            VStack(spacing: 18) {
                if result == "" {
                    Text(playerTurn == false ? "青の番！" : "待っててね")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }

                HStack(spacing: 10) {
                    Button { take(1, isBlue: true) } label: { oldLabel("一つ取る", color: .blue) }
                        .disabled(playerTurn == true || count < 1)
                    Button { take(2, isBlue: true) } label: { oldLabel("二つ取る", color: .blue) }
                        .disabled(playerTurn == true || count < 2)
                    Button { take(3, isBlue: true) } label: { oldLabel("三つ取る", color: .blue) }
                        .disabled(playerTurn == true || count < 3)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .background(.blue.gradient)

            // 真ん中
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

            // 下半分：赤
            VStack(spacing: 18) {
                HStack(spacing: 10) {
                    Button { take(1, isBlue: false) } label: { oldLabel("一つ取る", color: .red) }
                        .disabled(playerTurn == false || count < 1)
                    Button { take(2, isBlue: false) } label: { oldLabel("二つ取る", color: .red) }
                        .disabled(playerTurn == false || count < 2)
                    Button { take(3, isBlue: false) } label: { oldLabel("三つ取る", color: .red) }
                        .disabled(playerTurn == false || count < 3)
                }

                if result == "" {
                    Text(playerTurn ? "赤の番！" : "待っててね")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .background(.red.gradient)
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private func oldLabel(_ title: String, color: Color) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(color)
            .frame(maxWidth: .infinity, minHeight: 72)
            .background(.white, in: RoundedRectangle(cornerRadius: 14))
    }

    private func take(_ amount: Int, isBlue: Bool) {
        guard count >= amount, result == "" else { return }
        count -= amount
        if count == 0 {
            result = isBlue ? "青の負け！" : "赤の負け！"
        } else {
            playerTurn = isBlue
        }
    }
}

#Preview {
    ContentView()
}
