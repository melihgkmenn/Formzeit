#if os(macOS)
import AppIntents

struct WidgetLumeOptions: DynamicOptionsProvider {
  func results() async throws -> IntentItemCollection<String> {
    IntentItemCollection(sections: [
      IntentItemSection(items: LumeColor.allCases.map { IntentItem($0.rawValue, title: $0.title) })
    ])
  }
}
#endif
