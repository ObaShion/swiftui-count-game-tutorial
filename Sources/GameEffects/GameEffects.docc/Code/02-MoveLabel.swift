private func moveLabel(_ amount: Int, color: Color) -> some View {
    VStack(spacing: 2) {
        Text("\(amount)")
            .font(.title.bold())
        Text("とる")
            .font(.caption.bold())
    }
    .foregroundStyle(color)
    .frame(maxWidth: .infinity, minHeight: 70)
    .background(.white, in: RoundedRectangle(cornerRadius: 16))
    .shadow(color: .black.opacity(0.18), radius: 4, y: 3)
}
