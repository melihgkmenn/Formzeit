import AppIntents
import Foundation

struct LaunchClockIntent: AppIntent {
  static var title: LocalizedStringResource = "Formzeit’i aç"
  static var openAppWhenRun = true
  func perform() async throws -> some IntentResult {
    UserDefaults.standard.set(true, forKey: "openClockRequested")
    return .result()
  }
}
