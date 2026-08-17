// 下半分：赤
VStack(spacing: 18) {
    HStack(spacing: 8) {
        // 赤のボタンはこの中に置くよ！
    }

    turnLabel(name: "赤", isCurrent: playerTurn)
}
.frame(maxWidth: .infinity, maxHeight: .infinity)
.padding(20)
.background(.red.gradient)
