# SwiftUI Count Game Tutorial

SwiftUI で数取りゲームを楽しくレベルアップする、中高生向けの教材だよ！
5つの DocC Tutorials、演出を追加できる Swift Package `GameEffects`、そのまま
Xcodeで開ける完成版プロジェクトが入っています。

## DocC チュートリアル

公開版は GitHub Pages ですぐに読めるよ！ 「Tutorials」として、手を動かしながら
順番に進められます。

**[チュートリアルを開く](https://obashion.github.io/swiftui-count-game-tutorial/tutorials/table-of-contents/)**

自分のMacでプレビューしたいときは、リポジトリの一番上で次を実行してみよう！

```bash
swift package --disable-sandbox preview-documentation --target GameEffects
```

## 完成版を動かしてみよう！

[`Examples/CountGameComplete`](Examples/CountGameComplete) の
`CountGameComplete.xcodeproj` をXcodeで開けば、完成したゲームをそのまま実行できます！
`ContentView.swift` の下には3つの `#Preview` もあるので、「赤の番」「青の番」
「ゲーム終了」をすぐに見比べられるよ。

## GameEffects を追加しよう！

Xcode の **File > Add Package Dependencies...** に次の URL を入力します。

```text
https://github.com/ObaShion/swiftui-count-game-tutorial
```

`GameEffects` ライブラリをアプリのターゲットへ追加して、使いたい Swift ファイルに
`import GameEffects` と書けば準備完了！ 対応環境は iOS 17 以上だよ。

## 内容

- `Sources/GameEffects` — 効果音、触覚、アニメーション、紙吹雪の Swift Package
- `Sources/GameEffects/GameEffects.docc` — 日本語の DocC Tutorialsと8枚の実画面画像
- `Examples/CountGameComplete` — Xcodeで開ける完成版プロジェクト
- `Examples/CountGameStarter` — ファイルをコピーして試せる別形式のサンプル
- `PACKAGE.md` — `GameEffects` の API と導入方法

## ビルド

```bash
swift build
swift package --allow-writing-to-directory ./docs \
  generate-documentation --target GameEffects --output-path ./docs \
  --transform-for-static-hosting \
  --hosting-base-path swiftui-count-game-tutorial
```

`main` ブランチへpushすると、GitHub ActionsがDocCを作り、GitHub Pagesへ
自動で公開してくれるよ！
