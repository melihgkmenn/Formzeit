import SwiftUI
import AppIntents

enum DialStyle: String, CaseIterable, Identifiable, Codable, AppEnum {
  case solar, ivory, lagoon, forest, sky, rose, lilac, graphite
  case ocean, burgundy, cobalt, tangerine, peach, sand, pistachio, olive, terracotta, plum, blush, porcelain
  var id: String { rawValue }
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Kadran")
  static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
    .solar: "Güneş", .ivory: "Fildişi", .lagoon: "Lagün", .forest: "Orman",
    .sky: "Gökyüzü", .rose: "Gül", .lilac: "Leylak", .graphite: "Grafit",
    .ocean: "Okyanus", .burgundy: "Bordo", .cobalt: "Kobalt", .tangerine: "Mandalina",
    .peach: "Şeftali", .sand: "Kum", .pistachio: "Fıstık", .olive: "Zeytin",
    .terracotta: "Toprak", .plum: "Mürdüm", .blush: "Pudra", .porcelain: "Porselen"
  ]
  var title: LocalizedStringResource {
    switch self {
    case .solar: "Güneş"
    case .ivory: "Fildişi"
    case .lagoon: "Lagün"
    case .forest: "Orman"
    case .sky: "Gökyüzü"
    case .rose: "Gül"
    case .lilac: "Leylak"
    case .graphite: "Grafit"
    case .ocean: "Okyanus"
    case .burgundy: "Bordo"
    case .cobalt: "Kobalt"
    case .tangerine: "Mandalina"
    case .peach: "Şeftali"
    case .sand: "Kum"
    case .pistachio: "Fıstık"
    case .olive: "Zeytin"
    case .terracotta: "Toprak"
    case .plum: "Mürdüm"
    case .blush: "Pudra"
    case .porcelain: "Porselen"
    }
  }
  var color: Color {
    switch self {
    case .solar: Color(hex: 0xF4C641)
    case .ivory: Color(hex: 0xE6E1D3)
    case .lagoon: Color(hex: 0xA7DCD2)
    case .forest: Color(hex: 0x18795C)
    case .sky: Color(hex: 0x85CAE3)
    case .rose: Color(hex: 0xE6B9BD)
    case .lilac: Color(hex: 0xC4C1E4)
    case .graphite: Color(hex: 0x343936)
    case .ocean: Color(hex: 0x174C63)
    case .burgundy: Color(hex: 0x713646)
    case .cobalt: Color(hex: 0x335AC1)
    case .tangerine: Color(hex: 0xEF9741)
    case .peach: Color(hex: 0xF3C4A3)
    case .sand: Color(hex: 0xD5C29B)
    case .pistachio: Color(hex: 0xC5D5A6)
    case .olive: Color(hex: 0x69734B)
    case .terracotta: Color(hex: 0xB86E54)
    case .plum: Color(hex: 0x62415F)
    case .blush: Color(hex: 0xEED4D0)
    case .porcelain: Color(hex: 0xF2F0E9)
    }
  }
  var ink: Color {
    switch self {
    case .forest, .graphite, .ocean, .burgundy, .cobalt, .olive, .terracotta, .plum: Color(hex: 0xF0F1DE)
    default: Color(hex: 0x26362C)
    }
  }
  var brandColor: Color {
    switch self {
    case .forest, .graphite, .ocean, .burgundy, .cobalt, .olive, .terracotta, .plum:
      FormzeitBrand.lightAmber
    default:
      FormzeitBrand.amber
    }
  }
  var subtitle: LocalizedStringResource {
    switch self {
    case .solar: "Günün en sıcak tonu."
    case .ivory: "Sessiz, yalın, zamansız."
    case .lagoon: "Biraz su, biraz dinginlik."
    case .forest: "Doğanın kendi ritmi."
    case .sky: "Ufka açılan bir pencere."
    case .rose: "Zamana yumuşak bir dokunuş."
    case .lilac: "Sakinliğin başka bir tonu."
    case .graphite: "Güçlü bir sadelik."
    case .ocean: "Derin mavinin dinginliği."
    case .burgundy: "Klasik, sıcak, karakterli."
    case .cobalt: "Mavinin cesur hâli."
    case .tangerine: "Her güne biraz enerji."
    case .peach: "Günün yumuşak ışığı."
    case .sand: "Doğal bir denge."
    case .pistachio: "Taze ve hafif."
    case .olive: "Sakin bir Akdeniz tonu."
    case .terracotta: "Toprağın sıcaklığı."
    case .plum: "Derin, zarif, farklı."
    case .blush: "Hafif bir renk dokunuşu."
    case .porcelain: "Işığın en yalın hâli."
    }
  }
}

extension Color {
  init(hex: UInt32) {
    self.init(.sRGB, red: Double((hex >> 16) & 255) / 255,
              green: Double((hex >> 8) & 255) / 255, blue: Double(hex & 255) / 255, opacity: 1)
  }
}
