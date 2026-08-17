VStack(spacing: 4) {
    Text(result == "" ? "残りの数" : result)
        .font(.headline)
        .foregroundStyle(result == "" ? Color.secondary : Color.red)

    Text("\(count)")
        .font(.system(size: 64, weight: .black, design: .rounded))
}
.frame(maxWidth: .infinity)
.padding(.vertical, 18)
.background(.white)
