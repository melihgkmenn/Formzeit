#if os(macOS)
import AppIntents

struct WidgetDialOptions: DynamicOptionsProvider {
  func results() async throws -> IntentItemCollection<String> {
    IntentItemCollection(sections: [
      IntentItemSection(items: DialStyle.allCases.map { IntentItem($0.rawValue, title: $0.title) })
    ])
  }
}
#endif
