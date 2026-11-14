#if os(macOS)
import AppIntents

struct WidgetLanguageOptions: DynamicOptionsProvider {
  func results() async throws -> IntentItemCollection<String> {
    IntentItemCollection(sections: [
      IntentItemSection(items: AppLanguage.allCases.map { IntentItem($0.rawValue, title: $0.title) })
    ])
  }
}
#endif
