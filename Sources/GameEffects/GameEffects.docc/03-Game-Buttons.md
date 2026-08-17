# 3. 押したくなるボタンにしよう

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（10分）

- `Label` と SF Symbols を使って、意味が伝わるボタンを作れる。
- 押せないボタンの見た目を変えられる。

小さい文字だけのボタンは、急いでいると押し間違えやすくなります。数字を大きくして、アイコンと色を使いましょう。

## 「1つ取る」ボタンを変える

今ある `Text("一つ取る")` の部分を、次のように置き換えます。

```swift
Label("1", systemImage: "minus.circle.fill")
    .font(.title.bold())
    .frame(maxWidth: .infinity, minHeight: 64)
    .foregroundStyle(.white)
    .background(.red.gradient, in: RoundedRectangle(cornerRadius: 18))
    .shadow(color: .black.opacity(0.25), radius: 5, y: 4)
```

赤のボタンでは `.red.gradient`、青のボタンでは `.blue.gradient` にします。`maxWidth: .infinity` は「横に広がれるだけ広がる」という意味です。

## ボタンを横にきれいに並べる

1〜3のボタンを入れる `HStack` に、次のように間隔を付けます。

```swift
HStack(spacing: 12) {
    // 1、2、3のボタン
}
.padding(.horizontal, 20)
```

## 残りが足りないときは押せないようにする

たとえば「3」のボタンは、残りが3未満なら押せないようにします。

```swift
.disabled(!playerTurn || gameOver || count < 3)
.opacity((!playerTurn || gameOver || count < 3) ? 0.35 : 1)
```

青側は `!playerTurn` の代わりに `playerTurn` です。`.opacity` の値が小さいほど、薄く見えます。

## チェックポイント

- 1、2、3の数字とマイナスのアイコンが見える。
- ボタンに角丸と影がある。
- 取れない数のボタンは薄く、押しても数字が変わらない。

## うまくいかないとき

**`Label` が見つからない**

ファイルの先頭に `import SwiftUI` があるか確認しましょう。

**青の番なのに赤が押せる**

赤用の `.disabled` が `!playerTurn` になっているか確認します。赤の番は `playerTurn == true` です。

