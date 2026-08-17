ZStack {
    VStack(spacing: 0) {
        // 青・中央・赤の画面が入るよ！
    }

    GameOverEffect(trigger: gameOverEffectTrigger)
        .allowsHitTesting(false)
}
.specialEffect(trigger: specialEffectTrigger)

// 数字を表示するTextへ追加しよう！
Text("\(count)")
    .contentTransition(.numericText())
    .gameCountEffect(trigger: countEffectTrigger)
