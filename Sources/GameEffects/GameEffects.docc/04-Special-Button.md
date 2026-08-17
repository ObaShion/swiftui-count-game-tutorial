# 4. 1回だけ使えるスペシャルワザ

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（15分）

- 「一度使ったか」を `Bool` で覚えられる。
- 赤・青それぞれに、5個取るスペシャルボタンを付けられる。

毎回同じ数だけ取れるゲームには、先に有利な手順を知っている人が勝ちやすい場合があります。1回だけ使える5個取りを入れると、どのタイミングで使うか考える面白さが生まれます。

## 使用済みを覚える箱を作る

`@State` の近くに、次の2行を追加します。

```swift
@State private var redSpecialUsed = false
@State private var blueSpecialUsed = false
```

`Bool` は `true`（本当）か `false`（ちがう）だけを入れられる型です。最初は、どちらもまだ使っていないので `false` です。

## 赤のスペシャルボタン

赤の1〜3ボタンの近くに、次のボタンを追加します。

```swift
Button {
    count -= 5
    redSpecialUsed = true
    playerTurn = false
    if count <= 0 {
        result = "赤の負け！"
        gameOver = true
    }
} label: {
    Label(redSpecialUsed ? "使用済み" : "5", systemImage: "bolt.fill")
        .font(.title2.bold())
        .frame(maxWidth: .infinity, minHeight: 56)
        .foregroundStyle(.black)
        .background(.yellow.gradient, in: RoundedRectangle(cornerRadius: 18))
}
.disabled(!playerTurn || gameOver || redSpecialUsed || count < 5)
.opacity((!playerTurn || gameOver || redSpecialUsed || count < 5) ? 0.35 : 1)
```

## 青のスペシャルボタン

赤のコードをコピーして青側へ置き、次の3か所だけ変えます。

- `redSpecialUsed` を `blueSpecialUsed` にする。
- `!playerTurn` を `playerTurn` にする。
- `playerTurn = false` を `playerTurn = true` にする。
- 負けのメッセージを `"青の負け！"` にする。

## 大事なルール

5未満のときに5を取ると、残数がマイナスになってしまいます。そこで `.disabled(... || count < 5)` を必ず入れます。

## チェックポイント

- 赤・青がそれぞれ一度だけ5を取れる。
- 使った後は「使用済み」と表示され、もう押せない。
- 残りが4以下なら、スペシャルボタンは薄くなる。
- 5を取って0にしたプレイヤーが負けになる。

## うまくいかないとき

**赤がスペシャルを何度も使える**

ボタンを押したときの `redSpecialUsed = true` と、`.disabled(... || redSpecialUsed ...)` の両方が必要です。

**青で押すと赤の表示が変わる**

青用にコピーしたコードの `redSpecialUsed` が残っていないか、Xcodeの検索で確認しましょう。

