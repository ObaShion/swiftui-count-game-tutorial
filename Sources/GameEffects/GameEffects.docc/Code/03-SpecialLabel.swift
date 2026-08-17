private func specialLabel(isUsed: Bool) -> some View {
    VStack(spacing: 2) {
        Image(systemName: isUsed ? "checkmark" : "bolt.fill")
            .font(.title3.bold())
        Text(isUsed ? "使用済み" : "5とる")
            .font(.caption.bold())
    }
    .foregroundStyle(.black)
    .frame(maxWidth: .infinity, minHeight: 70)
    .background(.yellow.gradient, in: RoundedRectangle(cornerRadius: 16))
}
