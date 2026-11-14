import SwiftUI

enum FormzeitBrand {
  static let amber = Color(hex: 0x92520C)
  static let lightAmber = Color(hex: 0xE9B66E)

  static func color(onDark: Bool) -> Color { onDark ? lightAmber : amber }
}
