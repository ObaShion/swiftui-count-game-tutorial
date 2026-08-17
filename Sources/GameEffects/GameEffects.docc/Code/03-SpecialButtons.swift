// 青側のHStackの最後に追加しよう！
Button {
    take(5, isBlue: true, isSpecial: true)
} label: {
    specialLabel(isUsed: blueSpecialUsed)
}
.disabled(playerTurn == true || count < 5 || blueSpecialUsed || result != "")

// 赤側では isBlue を false にするよ！
Button {
    take(5, isBlue: false, isSpecial: true)
} label: {
    specialLabel(isUsed: redSpecialUsed)
}
.disabled(playerTurn == false || count < 5 || redSpecialUsed || result != "")
