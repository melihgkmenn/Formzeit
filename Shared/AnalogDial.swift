import SwiftUI

struct AnalogDial: View {
  var date: Date
  var style: DialStyle = .solar
  var city: ClockCity = .local
  var night = false
  var movement: ClockMovement = .mechanical
  var showBrand = true
  var showSeconds = true
  var lume: Color = Color(hex: 0x8DE6CE)
  @Environment(\.locale) private var locale

  var body: some View {
    let reading = ClockReading(date: date, city: city, movement: movement)
    Canvas { context, size in
      let side = min(size.width, size.height)
      let center = CGPoint(x: size.width / 2, y: size.height / 2)
      let radius = side / 2
      let ink = night ? lume : style.ink
      let face = night ? Color(hex: 0x090F0D) : style.color
      let dialRect = CGRect(x: center.x - radius, y: center.y - radius, width: side, height: side)
      context.fill(Path(ellipseIn: dialRect), with: .color(face))
      context.stroke(Path(ellipseIn: dialRect.insetBy(dx: side * 0.006, dy: side * 0.006)), with: .color(ink.opacity(night ? 0.08 : 0.12)), lineWidth: side * 0.002)
      func point(_ angle: Double, _ distance: Double) -> CGPoint {
        CGPoint(x: center.x + sin(angle) * distance, y: center.y - cos(angle) * distance)
      }
      for tick in 0..<60 {
        let angle = Double(tick) * .pi / 30
        let major = tick % 5 == 0
        var line = Path()
        line.move(to: point(angle, radius * (major ? 0.83 : 0.866)))
        line.addLine(to: point(angle, radius * 0.91))
        context.stroke(line, with: .color(ink.opacity(major ? 0.95 : (night ? 0.28 : 0.5))), style: StrokeStyle(lineWidth: side * (major ? 0.012 : 0.0035), lineCap: .round))
        if major && !night {
          var highlight = Path()
          highlight.move(to: point(angle, radius * 0.837))
          highlight.addLine(to: point(angle, radius * 0.903))
          context.stroke(highlight, with: .color(.white.opacity(0.8)), style: StrokeStyle(lineWidth: side * 0.005, lineCap: .round))
        }
      }
      for number in 1...12 {
        let position = point(Double(number) * .pi / 6, radius * 0.689)
        context.draw(Text("\(number)").font(.system(size: side * 0.071, weight: .regular, design: .rounded)).foregroundStyle(ink), at: position)
      }
      if showBrand {
        context.draw(Text("FORMZEIT").font(.system(size: side * 0.026, weight: .semibold, design: .monospaced)).tracking(side * 0.005).foregroundStyle(night ? FormzeitBrand.lightAmber : style.brandColor), at: CGPoint(x: center.x, y: center.y - side * 0.155))
        context.draw(Text(movement == .mechanical ? "M E C H A N I C A L" : "F O R M  &  T I M E").font(.system(size: side * 0.017, weight: .medium)).foregroundStyle(ink.opacity(0.55)), at: CGPoint(x: center.x, y: center.y + side * 0.19))
        context.draw(Text(city.title).font(.system(size: side * 0.019, weight: .medium)).tracking(side * 0.003).foregroundStyle(ink.opacity(0.6)), at: CGPoint(x: center.x, y: center.y + side * 0.225))
      }
      func hand(_ angle: Double, length: Double, width: Double) {
        var path = Path()
        path.move(to: point(angle, -radius * 0.11))
        path.addLine(to: point(angle, radius * length))
        var shadow = context
        shadow.addFilter(.shadow(color: .black.opacity(night ? 0 : 0.27), radius: side * 0.009, x: side * 0.004, y: side * 0.007))
        shadow.stroke(path, with: .color(night ? lume.opacity(0.85) : Color(hex: 0xF7F5EB)), style: StrokeStyle(lineWidth: side * width, lineCap: .round))
        context.stroke(path, with: .color(night ? lume : .white), style: StrokeStyle(lineWidth: side * width * 0.35, lineCap: .round))
      }
      hand(reading.hour.radians, length: 0.49, width: 0.026)
      hand(reading.minute.radians, length: 0.75, width: 0.019)
      if showSeconds && movement.showsSeconds {
        let angle = reading.second.radians
        var second = Path()
        second.move(to: point(angle, -radius * 0.19))
        second.addLine(to: point(angle, radius * 0.85))
        context.stroke(second, with: .color(night ? lume.opacity(0.6) : Color(hex: 0xB64F32)), style: StrokeStyle(lineWidth: side * 0.004, lineCap: .round))
      }
      context.fill(Path(ellipseIn: CGRect(x: center.x - side * 0.016, y: center.y - side * 0.016, width: side * 0.032, height: side * 0.032)), with: .color(night ? lume : Color(hex: 0xE4E5DC)))
      context.fill(Path(ellipseIn: CGRect(x: center.x - side * 0.006, y: center.y - side * 0.006, width: side * 0.012, height: side * 0.012)), with: .color(ink))
    }
    .aspectRatio(1, contentMode: .fit)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("\(Text(city.title)), \(city.time(date, locale: locale)), \(Text(style.title))"))
    .accessibilityValue(night ? Text("Gece modu") : Text("Gündüz"))
  }
}
