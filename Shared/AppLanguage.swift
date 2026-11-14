import SwiftUI
import AppIntents

enum AppLanguage: String, CaseIterable, Identifiable, Codable, AppEnum {
  case system
  case turkish = "tr"
  case english = "en"
  case german = "de"
  case french = "fr"
  case spanish = "es"
  case italian = "it"
  case arabic = "ar"
  case danish = "da"
  case dutch = "nl"
  case finnish = "fi"
  case indonesian = "id"
  case japanese = "ja"
  case korean = "ko"
  case norwegian = "nb"
  case polish = "pl"
  case portuguese = "pt"
  case romanian = "ro"
  case russian = "ru"
  case chinese = "zh-Hans"
  case swedish = "sv"
  case thai = "th"
  case vietnamese = "vi"
  var id: String { rawValue }
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Dil")
  static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
    .system: "Sistem dili",
    .turkish: "Türkçe",
    .english: "English",
    .german: "Deutsch",
    .french: "Français",
    .spanish: "Español",
    .italian: "Italiano",
    .arabic: "العربية",
    .danish: "Dansk",
    .dutch: "Nederlands",
    .finnish: "Suomi",
    .indonesian: "Bahasa Indonesia",
    .japanese: "日本語",
    .korean: "한국어",
    .norwegian: "Norsk bokmål",
    .polish: "Polski",
    .portuguese: "Português",
    .romanian: "Română",
    .russian: "Русский",
    .chinese: "简体中文",
    .swedish: "Svenska",
    .thai: "ไทย",
    .vietnamese: "Tiếng Việt",
  ]
  var title: LocalizedStringResource {
    switch self {
    case .system: "Sistem dili"
    case .turkish: "Türkçe"
    case .english: "English"
    case .german: "Deutsch"
    case .french: "Français"
    case .spanish: "Español"
    case .italian: "Italiano"
    case .arabic: "العربية"
    case .danish: "Dansk"
    case .dutch: "Nederlands"
    case .finnish: "Suomi"
    case .indonesian: "Bahasa Indonesia"
    case .japanese: "日本語"
    case .korean: "한국어"
    case .norwegian: "Norsk bokmål"
    case .polish: "Polski"
    case .portuguese: "Português"
    case .romanian: "Română"
    case .russian: "Русский"
    case .chinese: "简体中文"
    case .swedish: "Svenska"
    case .thai: "ไทย"
    case .vietnamese: "Tiếng Việt"
    }
  }
  var locale: Locale { self == .system ? .autoupdatingCurrent : Locale(identifier: rawValue) }
  var layoutDirection: LayoutDirection {
    locale.language.characterDirection == .rightToLeft ? .rightToLeft : .leftToRight
  }
}
