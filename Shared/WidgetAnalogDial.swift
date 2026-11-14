import SwiftUI
import WidgetKit

struct WidgetAnalogDial: View {
  var date: Date
  var style: DialStyle
  var city: ClockCity
  var night: Bool
  var lume: LumeColor
  @Environment(\.widgetRenderingMode) private var renderingMode
  @Environment(\.locale) private var locale

  private var fullColor: Bool { renderingMode == .fullColor }
  private var ink: Color { fullColor ? (night ? lume.color : style.ink) : .primary }

  var body: some View {
    GeometryReader { geometry in
      let side = min(geometry.size.width, geometry.size.height)
      let reading = ClockReading(date: date, city: city, movement: .digital)
      ZStack {
        if fullColor {
          Circle().fill(night ? Color(hex: 0x090F0D) : style.color)
        }
        Circle().strokeBorder(ink.opacity(fullColor ? 0.1 : 0.24), lineWidth: max(1, side * 0.003))
        ForEach(0..<60) { tick in
          Capsule()
            .fill(ink.opacity(tick % 5 == 0 ? 1 : 0.35))
            .frame(width: side * (tick % 5 == 0 ? 0.012 : 0.0035), height: side * (tick % 5 == 0 ? 0.045 : 0.02))
            .offset(y: -side * 0.44)
            .rotationEffect(.degrees(Double(tick) * 6))
        }
        ForEach(1..<13) { number in
          let angle = Double(number) * .pi / 6
          Text(number, format: .number)
            .font(.system(size: side * 0.073, weight: .medium, design: .rounded))
            .foregroundStyle(ink)
            .position(x: side / 2 + sin(angle) * side * 0.34, y: side / 2 - cos(angle) * side * 0.34)
        }
        if side > 95 {
          Text("FORMZEIT")
            .font(.system(size: side * 0.026, weight: .semibold, design: .monospaced))
            .tracking(side * 0.003)
            .foregroundStyle(fullColor ? (night ? FormzeitBrand.lightAmber : style.brandColor) : ink)
            .offset(y: -side * 0.16)
        }
        hand(reading.hour, side: side, length: 0.255, width: 0.026)
        hand(reading.minute, side: side, length: 0.38, width: 0.019)
        Circle().fill(ink).frame(width: side * 0.025, height: side * 0.025).widgetAccentable()
      }
      .frame(width: side, height: side)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .aspectRatio(1, contentMode: .fit)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel(Text("\(Text(city.title)) \(city.time(date, locale: locale))"))
  }

  private func hand(_ angle: Angle, side: Double, length: Double, width: Double) -> some View {
    Capsule()
      .fill(fullColor && !night ? Color(hex: 0xFAFAF1) : ink)
      .frame(width: side * width, height: side * length)
      .shadow(color: fullColor ? .black.opacity(0.25) : .clear, radius: side * 0.006, x: side * 0.004, y: side * 0.006)
      .offset(y: -side * length / 2 + side * 0.025)
      .rotationEffect(angle)
      .widgetAccentable()
  }
}
