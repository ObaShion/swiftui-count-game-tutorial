import SwiftUI

struct ContentView: View {
    @State private var count = 17
    @State private var result = ""
    @State private var playerTurn = true

    var body: some View {
        VStack {
            // 上半分：青
            VStack {
                if result == "" {
                    Text(playerTurn == false ? "青の番！" : "")
                        .font(.system(size: 28))
                        .foregroundStyle(.blue)
                }

                HStack {
                    Button {
                        if count > 0 {
                            count = count - 1
                            playerTurn = true
                        }

                        if count <= 0 {
                            result = "青の負け！"
                        } else {
                            result = ""
                        }
                    } label: {
                        Text("一つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.blue)
                    }
                    .disabled(playerTurn == true || count <= 0)

                    Button {
                        if count > 1 {
                            count = count - 2
                            playerTurn = true
                        }

                        if count <= 0 {
                            result = "青の負け！"
                        } else {
                            result = ""
                        }
                    } label: {
                        Text("二つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.blue)
                    }
                    .disabled(playerTurn == true || count <= 0)

                    Button {
                        if count > 2 {
                            count = count - 3
                            playerTurn = true
                        }

                        if count <= 0 {
                            result = "青の負け！"
                        } else {
                            result = ""
                        }
                    } label: {
                        Text("三つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.blue)
                    }
                    .disabled(playerTurn == true || count <= 0)
                }
            }
            .frame(maxHeight: .infinity)

            // 真ん中
            VStack {
                Text(result)
                    .font(.system(size: 32))

                Text("\(count)")
                    .font(.system(size: 64))
                    .bold()
            }

            // 下半分：赤
            VStack {
                HStack {
                    Button { takeFromRed(1) } label: {
                        Text("一つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.red)
                    }
                    .disabled(playerTurn == false || count <= 0)

                    Button { takeFromRed(2) } label: {
                        Text("二つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.red)
                    }
                    .disabled(playerTurn == false || count <= 0)

                    Button { takeFromRed(3) } label: {
                        Text("三つ取る")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 80)
                            .background(.red)
                    }
                    .disabled(playerTurn == false || count <= 0)
                }

                if result == "" {
                    Text(playerTurn ? "赤の番！" : "")
                        .font(.system(size: 28))
                        .foregroundStyle(.red)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }

    private func takeFromRed(_ amount: Int) {
        if count >= amount {
            count -= amount
            playerTurn = false
        }

        if count <= 0 {
            result = "赤の負け！"
        } else {
            result = ""
        }
    }
}

#Preview {
    ContentView()
}
