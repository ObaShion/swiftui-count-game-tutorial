# GameEffects

`GameEffects` is a tiny SwiftUI package for a beginner number-taking game. It
adds optional sounds, haptics, a number bounce, a special-action flash, and an
end-of-game confetti overlay. It has no images or sound files to configure.

## Add it in Xcode

1. In the app project, choose **File > Add Package Dependencies**.
2. Paste `https://github.com/ObaShion/swiftui-count-game-tutorial`, choose the
   desired version or branch, and add the
   `GameEffects` library to the app target.
3. Add `import GameEffects` at the top of `ContentView.swift`.

For a local workshop copy, use **File > Add Package Dependencies > Add Local**
and choose this repository's root folder instead.

The package supports iOS 17 and later (and builds on macOS 14 for development).
On devices or environments that cannot play a system sound or vibrate, the game
still works normally.

## Public API

```swift
import GameEffects

// Inside a Button action:
GameSound.play(.take)
GameFeedback.trigger(.take)

// Give each effect its own counter in the parent view:
Text("\\(count)")
    .gameCountEffect(trigger: countEffectTrigger)

VStack {
    // The full game screen
}
.specialEffect(trigger: specialEffectTrigger)

ZStack {
    // The game screen
    GameOverEffect(trigger: gameOverEffectTrigger)
}
```

Use `.special` for a one-time special button and `.gameOver` when a player
reaches zero. Increase the appropriate trigger integer every time the effect
should play; for example, `countEffectTrigger += 1`.
