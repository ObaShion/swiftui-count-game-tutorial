# 6. もう一度遊べるようにしよう

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（10分）

- 同じ初期化処理を `resetGame()` にまとめられる。
- ゲーム終了後に最初から遊べる。

「もう一度遊ぶ」では、残数だけでなく、手番・勝敗・スペシャルワザも最初に戻す必要があります。まとめて書くと、戻し忘れを防げます。

## リセット用の関数を作る

`body` の外、`ContentView` の中に次の関数を追加します。

```swift
private func resetGame() {
    count = 17
    result = ""
    playerTurn = true
    gameOver = false
    redSpecialUsed = false
    blueSpecialUsed = false
}
```

`playerTurn = true` にするので、再戦も赤から始まります。

## 終了したときだけ表示するボタン

勝敗メッセージの近くに、次のコードを追加します。

```swift
if gameOver {
    Button("もう一度遊ぶ") {
        resetGame()
    }
    .font(.title3.bold())
    .padding(.horizontal, 24)
    .padding(.vertical, 14)
    .background(.white, in: Capsule())
    .foregroundStyle(.black)
}
```

`if gameOver` は「ゲームが終わっているときだけ、この部品を画面に出す」という意味です。

## 最終チェック

次を、赤・青の両方で試してみましょう。

- 1、2、3を取ると正しい数だけ減る。
- 残数より大きいボタンは押せない。
- スペシャル5は1人につき1回だけ使える。
- 0にした人の負けが表示される。
- 終了後は通常・特殊ボタンが使えない。
- 「もう一度遊ぶ」で17、赤の番、未使用のスペシャルに戻る。

## うまくいかないとき

**再戦後も「使用済み」のまま**

`resetGame()` に `redSpecialUsed = false` と `blueSpecialUsed = false` の2行があるか確認しましょう。

**再戦後に青から始まる**

`resetGame()` の `playerTurn` が `true` か確認します。この教材では `true` が赤の番です。

## 次の挑戦

完成したら、<doc:Extension-Ideas>のアイデアを一つ選んで、自分だけのルールへ変えてみましょう。

