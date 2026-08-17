# 5. 音とエフェクトを付けよう

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（10分）

- Swift Package をXcodeへ追加できる。
- ボタンを押したときに音・振動・アニメーションを呼び出せる。

音や紙吹雪をゼロから作ると、ゲームの仕組みより難しくなります。この章では、授業用の `GameEffects` パッケージを使います。ゲーム本体では「呼び出す」ことに集中しましょう。

## パッケージを追加する

1. Xcodeのメニューで **File > Add Package Dependencies...** を選びます。
2. 検索欄に次のURLを貼り付けます。

```text
https://github.com/ObaShion/swiftui-count-game-tutorial
```

3. **Add Package** を押し、`GameEffects` をアプリのターゲットへ追加します。
4. `ContentView.swift` の先頭に次を追加します。

```swift
import GameEffects
```

> Tip: パッケージを追加したら、`GameEffects` ライブラリをアプリのターゲットに
> チェックしていることも確認してください。

## 数字を動かす準備

`@State` の近くに、数字の変化回数を数える箱を追加します。

```swift
@State private var countEffectTrigger = 0
@State private var specialEffectTrigger = 0
@State private var gameOverEffectTrigger = 0
```

残数を取る処理の最後で `countEffectTrigger += 1` と書くと、数字が変わったことをエフェクトへ伝えられます。

## 通常ボタンの音と振動

「1〜3を取る」ボタンの処理で、`count` を減らした直後に次を足します。

```swift
GameSound.play(.take)
GameFeedback.trigger(.take)
countEffectTrigger += 1
```

## スペシャルと終了の演出

スペシャルボタンの処理には次を追加します。

```swift
GameSound.play(.special)
GameFeedback.trigger(.special)
specialEffectTrigger += 1
```

0になってゲーム終了した分岐には、次を追加します。

```swift
GameSound.play(.gameOver)
GameFeedback.trigger(.gameOver)
gameOverEffectTrigger += 1
```

パッケージの説明に従い、残数の `Text` には `.gameCountEffect(trigger: countEffectTrigger)`、画面全体には `.specialEffect(trigger: specialEffectTrigger)` を付けます。終了紙吹雪は `ZStack` の最後に置きます。

```swift
GameOverEffect(trigger: gameOverEffectTrigger)
    .allowsHitTesting(false)
```

`allowsHitTesting(false)` は、紙吹雪がボタンを覆ってもタップを邪魔しない、という意味です。

## チェックポイント

- 通常ボタンで効果音と短い振動がある。
- 数字が変わると、少し弾む。
- スペシャルボタンで別の音と強めの演出がある。
- 終了時に紙吹雪と終了音が出る。

## うまくいかないとき

**`No such module 'GameEffects'` と出る**

パッケージを追加したターゲットがアプリ本体になっているか確認します。必要ならXcodeを一度閉じて開き直します。

**シミュレータで振動しない**

振動は実機で確認するのが確実です。シミュレータで振動しなくても、ゲームのバグではありません。

**音が出ない**

iPhoneの消音モード、音量、Bluetoothイヤホンへの出力先を確認しましょう。音がなくてもゲームは遊べるようにしておきます。
