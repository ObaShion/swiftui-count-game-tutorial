# Count Game Starter

ファイルを自分のXcodeプロジェクトへコピーして試せる完成サンプルだよ！
プロジェクトごと開きたいときは、となりの `CountGameComplete` を使ってね。
対象は **iOS 17以上**です。

## Xcodeへ入れるもの

1. Xcodeで **iOS App** を新しく作ろう！
2. プロジェクトの`App`ファイルを`CountGameApp.swift`の内容に置き換えよう！
3. `ContentView.swift`も、このフォルダの同名ファイルで置き換えよう！
4. プロジェクト設定の **Package Dependencies** で、
   `https://github.com/ObaShion/swiftui-count-game-tutorial` を追加します。
5. iPhoneシミュレータ（iOS 17以上）で実行します。

> オフラインの会場では、このリポジトリをダウンロードしてローカル Package として追加できます。

## できること

- 上が青、下が赤の2分割画面
- 赤・青が交互に1〜3個取るゲーム
- 0にした人が負け
- 各プレイヤーが1回だけ使える「5 とる」スペシャルボタン
- 数字のアニメーション、ボタン音、振動、ゲーム終了時の紙吹雪

## GameEffectsに必要な公開API

このサンプルは、教材用パッケージの次のAPIを使います。

```swift
GameSound.play(.take)
GameSound.play(.special)
GameSound.play(.gameOver)
GameFeedback.trigger(.take)
GameFeedback.trigger(.special)
GameFeedback.trigger(.gameOver)

// View modifier
.gameCountEffect(trigger: Int)

// View
GameOverEffect(trigger: Int)
```

`specialEffectID`は、パッケージに`specialEffect(trigger:)`が用意されたら画面の一番外側へ次の1行を追加して使用できます。

```swift
.specialEffect(trigger: specialEffectID)
```

## 動作確認

- 残りより多く取るボタンは押せない
- 手番でない側のボタンは押せない
- 「5 とる」は赤・青とも1ゲームに1回だけ使える
- 0にした人の負けが表示され、そこでゲームが終わる
