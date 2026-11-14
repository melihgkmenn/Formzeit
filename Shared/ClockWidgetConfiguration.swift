import AppIntents

struct ClockWidgetConfiguration: WidgetConfigurationIntent {
  static var title: LocalizedStringResource = "Saatini tasarla"
  static var description = IntentDescription("Kadran rengini, şehrini ve gece görünümünü seç.")
  #if os(macOS)
  // Keep the existing parameter names and persisted raw values. macOS can drop
  // AppEnum values during configuration resolution, so use labeled string options.
  @Parameter(title: "Kadran", default: "solar", optionsProvider: WidgetDialOptions()) var dial: String
  @Parameter(title: "Şehir", default: "local", optionsProvider: WidgetCityOptions()) var city: String
  @Parameter(title: "Gece fosforu", default: "mint", optionsProvider: WidgetLumeOptions()) var lume: String
  @Parameter(title: "Dil", default: "system", optionsProvider: WidgetLanguageOptions()) var language: String
  @Parameter(title: "İkinci şehir", default: "zurich", optionsProvider: WidgetCityOptions()) var secondCity: String
  @Parameter(title: "İkinci kadran", default: "lagoon", optionsProvider: WidgetDialOptions()) var secondDial: String
  @Parameter(title: "İkinci saat gece fosforu", optionsProvider: WidgetLumeOptions()) var secondLume: String?
  #else
  @Parameter(title: "Kadran", default: .solar) var dial: DialStyle
  @Parameter(title: "Şehir", default: .local) var city: ClockCity
  @Parameter(title: "Gece fosforu", default: .mint) var lume: LumeColor
  @Parameter(title: "Dil", default: .system) var language: AppLanguage
  @Parameter(title: "İkinci şehir", default: .zurich) var secondCity: ClockCity
  @Parameter(title: "İkinci kadran", default: .lagoon) var secondDial: DialStyle
  @Parameter(title: "İkinci saat gece fosforu") var secondLume: LumeColor?
  #endif
  @Parameter(title: "Gece görünümü", default: false) var night: Bool
  @Parameter(title: "Çift saat", default: false) var dual: Bool

  static var parameterSummary: some ParameterSummary {
    Summary("Saatini tasarla") {
      \.$dial
      \.$city
      \.$night
      \.$lume
      \.$language
      \.$dual
      \.$secondCity
      \.$secondDial
      \.$secondLume
    }
  }
}
