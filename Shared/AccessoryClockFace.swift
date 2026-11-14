import SwiftUI

struct AccessoryClockFace: View {
  var date: Date
  var city: ClockCity
  @Environment(\.locale) private var locale

  var body: some View {
    Canvas { context, size in
      let side = min(size.width, size.height)
      let radius = side * 0.47
      let center = CGPoint(x: size.width / 2, y: size.height / 2)
      func point(_ angle: Double, _ length: Double) -> CGPoint {
        CGPoint(x: center.x + sin(angle) * length, y: center.y - cos(angle) * length)
      }
      for tick in 0..<12 {
        let angle = Double(tick) * .pi / 6
        var mark = Path()
        mark.move(to: point(angle, radius * 0.84))
        mark.addLine(to: point(angle, radius))
        context.stroke(mark, with: .color(.primary.opacity(tick % 3 == 0 ? 1 : 0.45)), style: StrokeStyle(lineWidth: side * 0.035, lineCap: .round))
      }
      var calendar = Calendar(identifier: .gregorian)
      calendar.timeZone = city.timeZone
      let components = calendar.dateComponents([.hour, .minute], from: date)
      let minute = Double(components.minute ?? 0)
      let hour = Double((components.hour ?? 0) % 12) + minute / 60
      for (angle, length, width) in [(hour * .pi / 6, 0.5, 0.07), (minute * .pi / 30, 0.76, 0.045)] {
        var hand = Path()
        hand.move(to: point(angle, -radius * 0.12))
        hand.addLine(to: point(angle, radius * length))
        context.stroke(hand, with: .color(.primary), style: StrokeStyle(lineWidth: side * width, lineCap: .round))
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("\(Text(city.title)) \(city.time(date, locale: locale))"))
  }
}
