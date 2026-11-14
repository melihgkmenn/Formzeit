import SwiftUI
import Observation

@MainActor @Observable
final class ClockSettings {
  var style: DialStyle { didSet { save(style.rawValue, "dial") } }
  var secondStyle: DialStyle { didSet { save(secondStyle.rawValue, "secondDial") } }
  var appearance: ClockAppearance { didSet { save(appearance.rawValue, "appearance") } }
  var movement: ClockMovement { didSet { save(movement.rawValue, "movement") } }
  var showSeconds: Bool { didSet { save(showSeconds, "showSeconds") } }
  var city: ClockCity { didSet { save(city.rawValue, "city") } }
  var secondCity: ClockCity { didSet { save(secondCity.rawValue, "secondCity") } }
  var dual: Bool { didSet { save(dual, "dual") } }
  var landscapeFullScreen: Bool { didSet { save(landscapeFullScreen, "landscapeFullScreen") } }
  var keepAwake: Bool { didSet { save(keepAwake, "keepAwake") } }
  var inverted: Bool { didSet { save(inverted, "inverted") } }
  var lume: LumeColor { didSet { save(lume.rawValue, "lume") } }
  var secondLume: LumeColor { didSet { save(secondLume.rawValue, "secondLume") } }
  var language: AppLanguage { didSet { save(language.rawValue, "appLanguage") } }
  var followDeviceTimeZone: Bool { didSet { save(followDeviceTimeZone, "followDeviceTimeZone") } }
  var primaryCity: ClockCity { followDeviceTimeZone ? .local : city }
  private let defaults: UserDefaults
  init(defaults: UserDefaults = .standard) {
    self.defaults = defaults
    let d = defaults
    style = DialStyle(rawValue: d.string(forKey: "dial") ?? "") ?? .solar
    secondStyle = DialStyle(rawValue: d.string(forKey: "secondDial") ?? "") ?? .lagoon
    appearance = ClockAppearance(rawValue: d.string(forKey: "appearance") ?? "") ?? .day
    let savedMovement = ClockMovement(rawValue: d.string(forKey: "movement") ?? "") ?? .mechanical
    movement = savedMovement == .silent ? .mechanical : savedMovement
    showSeconds = d.object(forKey: "showSeconds") as? Bool ?? (savedMovement != .silent)
    city = ClockCity(rawValue: d.string(forKey: "city") ?? "") ?? .local
    secondCity = ClockCity(rawValue: d.string(forKey: "secondCity") ?? "") ?? .zurich
    dual = d.bool(forKey: "dual")
    landscapeFullScreen = d.object(forKey: "landscapeFullScreen") as? Bool ?? true
    keepAwake = d.object(forKey: "keepAwake") as? Bool ?? true
    inverted = d.bool(forKey: "inverted")
    let savedLume = LumeColor(rawValue: d.string(forKey: "lume") ?? "") ?? .mint
    lume = savedLume
    secondLume = LumeColor(rawValue: d.string(forKey: "secondLume") ?? "") ?? savedLume
    language = AppLanguage(rawValue: d.string(forKey: "appLanguage") ?? "") ?? .turkish
    followDeviceTimeZone = d.object(forKey: "followDeviceTimeZone") as? Bool ?? true
  }
  private func save(_ value: Any, _ key: String) { defaults.set(value, forKey: key) }
  func isNight(system: ColorScheme) -> Bool {
    appearance == .night || (appearance == .system && system == .dark)
  }
}

enum ClockAppearance: String, CaseIterable, Identifiable {
  case day, night, system
  var id: String { rawValue }
  var title: LocalizedStringResource {
    switch self { case .day: "Gündüz"; case .night: "Gece"; case .system: "Otomatik" }
  }
}
