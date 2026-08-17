# 2. 赤と青のフィールドを作ろう

@Metadata {
    @TitleHeading("チュートリアル")
    @PageKind(article)
}

## この章の目標（10分）

- `ZStack` と `VStack` の役割を説明できる。
- 画面の上半分を青、下半分を赤にできる。

`VStack` は部品を上から下へ並べます。`ZStack` は部品を重ねます。背景の上に数字カードを置きたいので、外側には `ZStack` を使います。

## 背景を重ねる

1. いちばん外側の `VStack` を `ZStack` に変えます。
2. `body` の最初に、次の背景を追加します。

```swift
VStack(spacing: 0) {
    Color.blue.opacity(0.75)
    Color.red.opacity(0.75)
}
.ignoresSafeArea()
```

3. もとのゲーム画面を、この背景の**あと**に置きます。

```swift
ZStack {
    VStack(spacing: 0) {
        Color.blue.opacity(0.75)
        Color.red.opacity(0.75)
    }
    .ignoresSafeArea()

    // ここに、今までのゲーム画面を置く
}
```

## 真ん中の数字を読みやすくする

残りの数を表示する `Text` に、白いカードの見た目を付けます。

```swift
Text("\\(count)")
    .font(.system(size: 72, weight: .bold, design: .rounded))
    .foregroundStyle(.primary)
    .frame(maxWidth: .infinity)
    .padding(.vertical, 28)
    .background(.white.opacity(0.92), in: RoundedRectangle(cornerRadius: 24))
    .padding(.horizontal, 32)
```

カードは背景と文字を分けてくれるので、どちらの色の上でも数字を読みやすくできます。

## 手番を文字でも伝える

色だけでなく、短い文字でも手番を知らせましょう。

```swift
Text(playerTurn ? "赤の番" : "青の番")
    .font(.title2.bold())
    .foregroundStyle(.white)
```

## チェックポイント

- 上半分が青、下半分が赤になっている。
- 残りの数が白いカードの上に大きく表示される。
- 「赤の番」または「青の番」が読める。

## うまくいかないとき

**背景だけが表示される**

ゲーム画面が背景の `VStack` より後ろになっているかもしれません。`ZStack` の中では、後に書いた部品ほど前に表示されます。

**背景が画面の端まで届かない**

背景の `VStack` に `.ignoresSafeArea()` を付けましょう。

