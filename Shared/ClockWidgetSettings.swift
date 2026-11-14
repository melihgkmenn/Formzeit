import Foundation

/// A value snapshot of the edited intent, independent of App Intents parameter storage.
struct ClockWidgetSettings: Codable, Hashable, Sendable {
  var dial: DialStyle
  var city: ClockCity
  var night: Bool
  var lume: LumeColor
  var language: AppLanguage
  var dual: Bool
  var secondCity: ClockCity
  var secondDial: DialStyle
  var secondLume: LumeColor?

  init(_ configuration: ClockWidgetConfiguration) {
    #if os(macOS)
    dial = DialStyle(rawValue: configuration.dial) ?? .solar
    city = ClockCity(rawValue: configuration.city) ?? .local
    lume = LumeColor(rawValue: configuration.lume) ?? .mint
    language = AppLanguage(rawValue: configuration.language) ?? .system
    secondCity = ClockCity(rawValue: configuration.secondCity) ?? .zurich
    secondDial = DialStyle(rawValue: configuration.secondDial) ?? .lagoon
    secondLume = configuration.secondLume.flatMap(LumeColor.init(rawValue:))
    #else
    dial = configuration.dial
    city = configuration.city
    lume = configuration.lume
    language = configuration.language
    secondCity = configuration.secondCity
    secondDial = configuration.secondDial
    secondLume = configuration.secondLume
    #endif
    night = configuration.night
    dual = configuration.dual
  }
}
