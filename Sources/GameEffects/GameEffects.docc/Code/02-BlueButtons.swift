HStack(spacing: 8) {
    Button { take(1, isBlue: true) } label: {
        moveLabel(1, color: .blue)
    }
    .disabled(playerTurn == true || count < 1 || result != "")

    Button { take(2, isBlue: true) } label: {
        moveLabel(2, color: .blue)
    }
    .disabled(playerTurn == true || count < 2 || result != "")

    Button { take(3, isBlue: true) } label: {
        moveLabel(3, color: .blue)
    }
    .disabled(playerTurn == true || count < 3 || result != "")
}
