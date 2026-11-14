#if os(macOS)
import AppIntents

struct WidgetCityOptions: DynamicOptionsProvider {
  func results() async throws -> IntentItemCollection<String> {
    IntentItemCollection(usesIndexedCollation: true, sections: [
      IntentItemSection(items: ClockCity.allCases.map { IntentItem($0.rawValue, title: $0.title) })
    ])
  }
}
#endif
