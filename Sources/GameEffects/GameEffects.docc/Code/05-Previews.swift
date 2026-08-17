#Preview("赤の番") {
    ContentView()
}

#Preview("青の番") {
    ContentView(previewCount: 12, previewPlayerTurn: false)
}

#Preview("ゲーム終了") {
    ContentView(
        previewCount: 0,
        previewResult: "赤の負け！",
        previewPlayerTurn: true,
        previewRedSpecialUsed: true,
        previewGameOverEffectTrigger: 1
    )
}
