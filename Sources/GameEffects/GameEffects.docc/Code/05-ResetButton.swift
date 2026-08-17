if result != "" {
    Button("もう一度あそぶ！", action: resetGame)
        .font(.headline.bold())
        .buttonStyle(.borderedProminent)
        .tint(.indigo)
        .accessibilityHint("17から新しいゲームを始めるよ")
}
