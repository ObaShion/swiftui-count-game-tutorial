HStack(spacing: 8) {
    Button { take(1, isBlue: false) } label: {
        moveLabel(1, color: .red)
    }
    .disabled(playerTurn == false || count < 1 || result != "")

    Button { take(2, isBlue: false) } label: {
        moveLabel(2, color: .red)
    }
    .disabled(playerTurn == false || count < 2 || result != "")

    Button { take(3, isBlue: false) } label: {
        moveLabel(3, color: .red)
    }
    .disabled(playerTurn == false || count < 3 || result != "")
}
