import SwiftUI

struct MovementOptionsView: View {
  @Binding var selection: ClockMovement
  @Binding var showSeconds: Bool
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  var body: some View {
    VStack(alignment: .leading, spacing: 14) {
      TimelineView(.animation(minimumInterval: 1.0 / 15, paused: reduceMotion)) { context in
        HStack(spacing: 8) {
          ForEach(ClockMovement.selectable) { movement in
            MovementFan(date: context.date, movement: movement)
              .frame(maxWidth: .infinity)
              .frame(height: 72)
              .background(.primary.opacity(selection == movement ? 0.08 : 0.03), in: RoundedRectangle(cornerRadius: 14))
              .overlay {
                RoundedRectangle(cornerRadius: 14).strokeBorder(selection == movement ? Color.primary.opacity(0.7) : .clear, lineWidth: 1.5)
              }
          }
        }
        .accessibilityHidden(true)
      }
      Text("Hızlandırılmış önizleme").font(.caption2).foregroundStyle(.secondary)
      Picker("Hareket", selection: $selection) {
        ForEach(ClockMovement.selectable) { Text($0.title).tag($0) }
      }
      .pickerStyle(.segmented)
      Text(selection.detail).font(.footnote).foregroundStyle(.secondary)
        .fixedSize(horizontal: false, vertical: true)
      if selection.showsSeconds {
        Toggle("Saniye ibresi", isOn: $showSeconds)
      }
    }
    .padding(.vertical, 5)
  }
}

private struct MovementFan: View {
  var date: Date
  var movement: ClockMovement

  var body: some View {
    Canvas { context, size in
      let origin = CGPoint(x: size.width / 2, y: size.height - 8)
      let radius = min(size.width * 0.45, size.height * 0.78)
      func point(_ angle: Double, _ scale: Double) -> CGPoint {
        CGPoint(x: origin.x + sin(angle) * radius * scale, y: origin.y - cos(angle) * radius * scale)
      }
      for tick in -3...3 {
        let angle = Double(tick) * .pi / 9
        var mark = Path()
        mark.move(to: point(angle, 0.72))
        mark.addLine(to: point(angle, 0.98))
        context.stroke(mark, with: .color(.primary.opacity(0.25)), style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
      }
      let raw = date.timeIntervalSinceReferenceDate
      let sampled: Double
      switch movement {
      case .mechanical, .silent: sampled = raw
      case .quartz: sampled = floor(raw)
      case .digital: sampled = floor(raw / 2) * 2
      }
      let angle = (-60 + sampled.truncatingRemainder(dividingBy: 8) * 15) * .pi / 180
      var hand = Path()
      hand.move(to: origin)
      hand.addLine(to: point(angle, 0.9))
      context.stroke(hand, with: .color(.primary), style: StrokeStyle(lineWidth: 3, lineCap: .round))
    }
  }
}
