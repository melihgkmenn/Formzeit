#if os(iOS)
import SwiftUI
import WidgetKit

struct LockScreenClockWidget: Widget {
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: "Formzeit.LockScreenClock", intent: ClockWidgetConfiguration.self, provider: ClockWidgetProvider()) { entry in
      LockScreenClockView(entry: entry)
        .id(entry.configuration)
        .environment(\.locale, entry.configuration.language.locale)
        .environment(\.layoutDirection, entry.configuration.language.layoutDirection)
        .containerBackground(.clear, for: .widget)
        .widgetURL(URL(string: "formzeit://clock"))
    }
    .configurationDisplayName("Formzeit • Kilit Ekranı")
    .description("Kilit Ekranı için sade analog saat, dijital saat ve saat dilimi.")
    .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
  }
}

private struct LockScreenClockView: View {
  var entry: ClockWidgetEntry
  @Environment(\.widgetFamily) private var family
  @Environment(\.locale) private var locale

  var body: some View {
    switch family {
    case .accessoryInline:
      Label {
        Text("\(Text(entry.configuration.city.title)) \(entry.configuration.city.time(entry.date, locale: locale))")
      } icon: { Image(systemName: "clock.fill") }
    case .accessoryCircular:
      ZStack {
        AccessoryWidgetBackground()
        AccessoryClockFace(date: entry.date, city: entry.configuration.city).padding(5)
      }
    default:
      HStack(spacing: 9) {
        AccessoryClockFace(date: entry.date, city: entry.configuration.city).frame(width: 44)
        VStack(alignment: .leading, spacing: 1) {
          Text(entry.configuration.city.title).font(.caption).lineLimit(1).minimumScaleFactor(0.7)
          Text(entry.configuration.city.time(entry.date, locale: locale)).font(.system(.title3, design: .rounded, weight: .semibold)).monospacedDigit()
          Text(entry.configuration.city.offset(at: entry.date)).font(.caption2)
        }
        Spacer(minLength: 0)
      }
    }
  }
}
#endif
