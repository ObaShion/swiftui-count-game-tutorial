count -= amount
countEffectTrigger += 1

if isSpecial {
    specialEffectTrigger += 1
}

if count == 0 {
    gameOverEffectTrigger += 1
}

GameSound.play(isSpecial ? .special : .take)
GameFeedback.trigger(isSpecial ? .special : .take)

if result != "" {
    GameSound.play(.gameOver)
    GameFeedback.trigger(.gameOver)
}
