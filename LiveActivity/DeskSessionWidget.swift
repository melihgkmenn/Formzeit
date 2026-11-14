import ActivityKit
import SwiftUI
import WidgetKit

@main
struct DeskSessionWidgetBundle: WidgetBundle {
  var body: some Widget { DeskSessionWidget() }
}

struct DeskSessionWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: DeskSessionAttributes.self) { context in
      DeskSessionBanner(context: context)
        .environment(\.locale, Locale(identifier: context.attributes.languageCode ?? Locale.autoupdatingCurrent.identifier))
        .environment(\.layoutDirection, Locale(identifier: context.attributes.languageCode ?? Locale.autoupdatingCurrent.identifier).language.characterDirection == .rightToLeft ? .rightToLeft : .leftToRight)
        .activityBackgroundTint(Color(red: 0.05, green: 0.1, blue: 0.08))
        .activitySystemActionForegroundColor(.mint)
        .widgetURL(URL(string: "formzeit://clock"))
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) { Label("Formzeit", systemImage: "clock.fill").foregroundStyle(Color(red: 0.914, green: 0.714, blue: 0.431)) }
        DynamicIslandExpandedRegion(.trailing) { Text(context.state.startedAt, style: .timer).monospacedDigit() }
        DynamicIslandExpandedRegion(.bottom) {
          Text("Masa saati oturumu").font(.caption).foregroundStyle(.secondary)
            .environment(\.locale, Locale(identifier: context.attributes.languageCode ?? Locale.autoupdatingCurrent.identifier))
        }
      } compactLeading: {
        Image(systemName: "clock.fill").foregroundStyle(.mint)
      } compactTrailing: {
        Text(context.state.startedAt, style: .timer).monospacedDigit().frame(maxWidth: 60)
      } minimal: {
        Image(systemName: "clock.fill").foregroundStyle(.mint)
      }
      .keylineTint(.mint)
      .widgetURL(URL(string: "formzeit://clock"))
    }
    .supplementalActivityFamilies([.small, .medium])
  }
}

private struct DeskSessionBanner: View {
  var context: ActivityViewContext<DeskSessionAttributes>
  @Environment(\.activityFamily) private var family
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: "clock.fill").font(family == .small ? .title2 : .largeTitle).foregroundStyle(.mint)
      VStack(alignment: .leading, spacing: 5) {
        Text("FORMZEIT").font(.system(.caption, design: .monospaced)).tracking(2).foregroundStyle(Color(red: 0.914, green: 0.714, blue: 0.431))
        Text(context.state.startedAt, style: .timer).font(family == .small ? .title3 : .title).monospacedDigit().foregroundStyle(.white)
        if family != .small { Text("Masa saati oturumu").font(.caption).foregroundStyle(.white.opacity(0.65)) }
      }
      Spacer(minLength: 0)
    }
    .padding(family == .small ? 10 : 20)
  }
}
