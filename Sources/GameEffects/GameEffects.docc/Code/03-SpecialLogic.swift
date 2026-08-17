private func take(_ amount: Int, isBlue: Bool, isSpecial: Bool = false) {
    guard count >= amount, result == "" else { return }
    count -= amount

    if isSpecial {
        if isBlue {
            blueSpecialUsed = true
        } else {
            redSpecialUsed = true
        }
    }

    if count == 0 {
        result = isBlue ? "青の負け！" : "赤の負け！"
    } else {
        playerTurn = isBlue
    }
}
