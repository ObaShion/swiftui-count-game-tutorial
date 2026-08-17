# 1. ゲームの「今」を覚えさせよう

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（5分）

- 画面に表示される値が、どの変数に入っているか説明できる。
- 終了したゲームを判定する `gameOver` を追加できる。

SwiftUIでは、画面に関係する「今の値」を `@State` に入れます。値が変わると、SwiftUIが画面を描き直してくれます。

## まず、今の3つの状態を確認

`ContentView` には、すでに次のような値があります。

```swift
@State private var count = 17
@State private var result = ""
@State private var playerTurn = true
```

この教材では `playerTurn == true` を「赤の番」、`false` を「青の番」と決めます。変数は箱だと考えると分かりやすいです。

| 箱 | 中身 | 画面で使う場所 |
| --- | --- | --- |
| `count` | 残っている数 | 真ん中の大きな数字 |
| `result` | 勝敗メッセージ | 数字の近くの文字 |
| `playerTurn` | どちらの番か | ボタンを押せるかどうか |

## 終了を表す箱を追加

1. `@State` が並んでいる場所に、次の1行を追加します。

```swift
@State private var gameOver = false
```

2. 数を取ったあと、`count <= 0` になったら `gameOver = true` にします。
3. 各ボタンの `.disabled(...)` に `|| gameOver` を足します。

例えば赤のボタンは、次のようにします。

```swift
.disabled(playerTurn == false || gameOver)
```

`||` は「または」です。青の番、またはゲーム終了なら、そのボタンは押せません。

## チェックポイント

- 赤が `0` にすると「赤の負け！」が表示される。
- 勝敗が出たあとは、どの「取る」ボタンも反応しない。

## うまくいかないとき

**`Cannot find 'gameOver' in scope` と出る**

`gameOver` の宣言が `struct ContentView: View {` の中にあるか確認しましょう。`body` の中ではなく、ほかの `@State` の近くに書きます。

**勝敗のあとも押せる**

赤・青すべての通常ボタンに `|| gameOver` を付けたか確認しましょう。

