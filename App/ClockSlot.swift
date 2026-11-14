import SwiftUI

enum ClockSlot: String, CaseIterable, Identifiable {
  case primary, secondary
  var id: String { rawValue }
  var title: LocalizedStringResource {
    switch self {
    case .primary: "Birinci saat"
    case .secondary: "İkinci saat"
    }
  }
}
