# GameEffects

`GameEffects` は、数取りゲームへ楽しい演出を足せる小さな SwiftUI Package だよ！
効果音、振動、数字のアニメーション、スペシャル技の光、ゲーム終了時の紙吹雪が
用意されています。画像や音声ファイルを自分で設定しなくても使えるよ。

## Xcodeへ追加しよう！

1. アプリのプロジェクトで **File > Add Package Dependencies** を選ぼう！
2. `https://github.com/ObaShion/swiftui-count-game-tutorial` を貼り付けて、
   `GameEffects` をアプリのターゲットへ追加しよう！
3. `ContentView.swift` の先頭に `import GameEffects` と書けば準備完了！

会場でオフライン利用するときは **Add Local** を選び、このリポジトリの一番上の
フォルダを指定すれば使えるよ！ iOS 17以上に対応しています。

The package supports iOS 17 and later (and builds on macOS 14 for development).
On devices or environments that cannot play a system sound or vibrate, the game
still works normally.

## 使える機能

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

一度だけ使えるスペシャルボタンでは `.special`、残りが0になったときは
`.gameOver` を使おう！ 演出をもう一度出すときは、対応する数字を
`countEffectTrigger += 1` のように増やせばいいよ。
