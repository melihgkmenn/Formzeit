import SwiftUI
import WidgetKit
import AppIntents
import OSLog

struct ClockWidget: Widget {
  var body: some WidgetConfiguration {
    AppIntentConfiguration(kind: "Formzeit.Clock", intent: ClockWidgetConfiguration.self, provider: ClockWidgetProvider()) { entry in
      ClockWidgetView(entry: entry)
        .id(entry.configuration)
        .environment(\.locale, entry.configuration.language.locale)
        .environment(\.layoutDirection, entry.configuration.language.layoutDirection)
        .containerBackground(entry.configuration.night ? Color(hex: 0x090F0D) : entry.configuration.dial.color.opacity(0.22), for: .widget)
        .widgetURL(URL(string: "formzeit://clock"))
    }
    .configurationDisplayName("Formzeit • Saat")
    .description("Kendi rengin, kendi şehrin. Tek veya çift analog saat.")
    #if os(watchOS)
    .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
    #elseif os(macOS)
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    #else
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline])
    #endif
  }
}

struct ClockWidgetProvider: AppIntentTimelineProvider {
  func recommendations() -> [AppIntentRecommendation<ClockWidgetConfiguration>] {
    [AppIntentRecommendation(intent: ClockWidgetConfiguration(), description: "Formzeit • Yerel saat")]
  }
  func placeholder(in context: Context) -> ClockWidgetEntry {
    ClockWidgetEntry(date: .now, configuration: ClockWidgetSettings(ClockWidgetConfiguration()))
  }
  func snapshot(for configuration: ClockWidgetConfiguration, in context: Context) async -> ClockWidgetEntry {
    ClockWidgetEntry(date: .now, configuration: settings(for: configuration, phase: "snapshot"))
  }
  func timeline(for configuration: ClockWidgetConfiguration, in context: Context) async -> Timeline<ClockWidgetEntry> {
    let now = Date()
    let start = Calendar.current.dateInterval(of: .minute, for: now)?.start ?? now
    let settings = settings(for: configuration, phase: "timeline")
    let entries = (0..<60).map { ClockWidgetEntry(date: start.addingTimeInterval(Double($0) * 60), configuration: settings) }
    return Timeline(entries: entries, policy: .atEnd)
  }

  private func settings(for configuration: ClockWidgetConfiguration, phase: String) -> ClockWidgetSettings {
    let settings = ClockWidgetSettings(configuration)
    #if DEBUG
    Logger(subsystem: Bundle.main.bundleIdentifier ?? "Formzeit.Widget", category: "Configuration")
      .info("\(phase, privacy: .public): dial=\(settings.dial.rawValue, privacy: .public), secondDial=\(settings.secondDial.rawValue, privacy: .public), night=\(settings.night), lume=\(settings.lume.rawValue, privacy: .public)")
    #endif
    return settings
  }
}

struct ClockWidgetEntry: TimelineEntry {
  var date: Date
  var configuration: ClockWidgetSettings
}

private struct ClockWidgetView: View {
  var entry: ClockWidgetEntry
  @Environment(\.widgetFamily) private var family
  @Environment(\.locale) private var locale
  var body: some View {
    switch family {
    case .accessoryInline:
      Text("\(Text(entry.configuration.city.title)) \(entry.configuration.city.time(entry.date, locale: locale))")
    case .accessoryCircular:
      dial(entry.configuration.city, style: entry.configuration.dial)
    case .accessoryRectangular:
      HStack {
        dial(entry.configuration.city, style: entry.configuration.dial)
        VStack(alignment: .leading) {
          Text(entry.configuration.city.title).font(.caption)
          Text(entry.configuration.city.time(entry.date, locale: locale)).font(.title3.monospacedDigit())
        }
      }
    default:
      #if os(watchOS)
      dial(entry.configuration.city, style: entry.configuration.dial)
      #else
      if (entry.configuration.dual || family == .systemMedium) && family != .systemSmall {
        HStack(spacing: 12) {
          clock(entry.configuration.city, style: entry.configuration.dial, lume: entry.configuration.lume)
          clock(entry.configuration.secondCity, style: entry.configuration.secondDial, lume: entry.configuration.secondLume ?? entry.configuration.lume)
        }
      } else {
        dial(entry.configuration.city, style: entry.configuration.dial)
      }
      #endif
    }
  }
  private func dial(_ city: ClockCity, style: DialStyle) -> some View {
    WidgetAnalogDial(date: entry.date, style: style, city: city, night: entry.configuration.night, lume: entry.configuration.lume)
  }
  private func clock(_ city: ClockCity, style: DialStyle, lume: LumeColor) -> some View {
    VStack(spacing: 5) {
      WidgetAnalogDial(date: entry.date, style: style, city: city, night: entry.configuration.night, lume: lume)
      Text(city.title).font(.system(.caption2, design: .monospaced)).foregroundStyle(entry.configuration.night ? lume.color : Color(hex: 0x26362C))
    }
  }
}
