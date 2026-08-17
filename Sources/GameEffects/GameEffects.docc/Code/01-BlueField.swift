// 上半分：青
VStack(spacing: 18) {
    turnLabel(name: "青", isCurrent: playerTurn == false)

    HStack(spacing: 8) {
        // 青のボタンはこの中に置くよ！
    }
}
.frame(maxWidth: .infinity, maxHeight: .infinity)
.padding(20)
.background(.blue.gradient)
