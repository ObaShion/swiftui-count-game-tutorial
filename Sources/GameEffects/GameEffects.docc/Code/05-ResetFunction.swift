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
