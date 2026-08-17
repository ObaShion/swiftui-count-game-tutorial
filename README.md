# SwiftUI Count Game Tutorial

中高生向けの SwiftUI 数取りゲーム教材です。リポジトリには、60分の DocC
チュートリアル、演出を追加する Swift Package `GameEffects`、完成サンプルが
含まれています。

## DocC チュートリアル

公開版は GitHub Pages で閲覧できます。

**[チュートリアルを開く](https://obashion.github.io/swiftui-count-game-tutorial/tutorials/table-of-contents/)**

ローカルでプレビューする場合は、リポジトリ直下で次を実行します。

```bash
swift package --disable-sandbox preview-documentation --target GameEffects
```

## GameEffects を追加する

Xcode の **File > Add Package Dependencies...** に次の URL を入力します。

```text
https://github.com/ObaShion/swiftui-count-game-tutorial
```

`GameEffects` ライブラリをアプリのターゲットへ追加し、使用する Swift ファイルで
`import GameEffects` を記述してください。対応環境は iOS 17 以上です。

## 内容

- `Sources/GameEffects` — 効果音、触覚、アニメーション、紙吹雪の Swift Package
- `Sources/GameEffects/GameEffects.docc` — 日本語の DocC チュートリアル
- `Examples/CountGameStarter` — 完成版 SwiftUI サンプル
- `PACKAGE.md` — `GameEffects` の API と導入方法

## ビルド

```bash
swift build
swift package --allow-writing-to-directory ./docs \
  generate-documentation --target GameEffects --output-path ./docs \
  --transform-for-static-hosting \
  --hosting-base-path swiftui-count-game-tutorial
```

`main` ブランチへの push では GitHub Actions が DocC を生成し、GitHub Pages へ
自動デプロイします。
