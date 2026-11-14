import SwiftUI
import AppIntents

enum LumeColor: String, CaseIterable, Identifiable, Codable, AppEnum {
  case mint, green, amber, ice, cyan, blue, violet, pink, coral, red, yellow, white
  var id: String { rawValue }
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Gece fosforu")
  static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
    .mint: "Nane", .green: "Yeşil", .amber: "Kehribar", .ice: "Buz",
    .cyan: "Turkuaz", .blue: "Mavi", .violet: "Mor", .pink: "Pembe",
    .coral: "Mercan", .red: "Kırmızı", .yellow: "Sarı", .white: "Beyaz"
  ]
  var title: LocalizedStringResource {
    switch self {
    case .mint: "Nane"
    case .green: "Yeşil"
    case .amber: "Kehribar"
    case .ice: "Buz"
    case .cyan: "Turkuaz"
    case .blue: "Mavi"
    case .violet: "Mor"
    case .pink: "Pembe"
    case .coral: "Mercan"
    case .red: "Kırmızı"
    case .yellow: "Sarı"
    case .white: "Beyaz"
    }
  }
  var color: Color {
    switch self {
    case .mint: Color(hex: 0x8DE6CE)
    case .green: Color(hex: 0xADDE73)
    case .amber: Color(hex: 0xE9B66E)
    case .ice: Color(hex: 0xA1D8F2)
    case .cyan: Color(hex: 0x6CE5EE)
    case .blue: Color(hex: 0x8FB5FF)
    case .violet: Color(hex: 0xC5A1FF)
    case .pink: Color(hex: 0xF4A9DB)
    case .coral: Color(hex: 0xFFB29A)
    case .red: Color(hex: 0xFF8585)
    case .yellow: Color(hex: 0xF3E18D)
    case .white: Color(hex: 0xF2F5EF)
    }
  }
}
