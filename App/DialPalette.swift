import SwiftUI

struct DialPalette: View {
  @Binding var selection: DialStyle
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 4) {
        ForEach(DialStyle.allCases) { style in
          Button {
            selection = style
          } label: {
            Circle()
              .fill(style.color)
              .frame(width: 27, height: 27)
              .overlay { if selection == style { Image(systemName: "checkmark").font(.system(size: 10, weight: .bold)).foregroundStyle(style.ink) } }
              .padding(5)
              .overlay { Circle().strokeBorder(selection == style ? Color.primary.opacity(0.65) : .clear, lineWidth: 1) }
              .frame(width: 44, height: 44)
              .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
          .accessibilityLabel(Text(style.title))
          .accessibilityAddTraits(selection == style ? [.isSelected] : [])
        }
      }
    }
    .scrollIndicators(.hidden)
    .frame(maxWidth: .infinity)
  }
}
