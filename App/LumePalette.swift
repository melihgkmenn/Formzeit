import SwiftUI

struct LumePalette: View {
  @Binding var selection: LumeColor
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 4) {
        ForEach(LumeColor.allCases) { lume in
          Button {
            selection = lume
          } label: {
            Circle().fill(lume.color).frame(width: 27, height: 27)
              .overlay {
                if selection == lume {
                  Image(systemName: "checkmark").font(.system(size: 10, weight: .bold)).foregroundStyle(.black)
                }
              }
              .padding(5)
              .overlay { Circle().strokeBorder(selection == lume ? Color.primary.opacity(0.65) : .clear, lineWidth: 1) }
              .frame(width: 44, height: 44).contentShape(Rectangle())
          }
          .buttonStyle(.plain)
          .accessibilityLabel(Text(lume.title))
          .accessibilityAddTraits(selection == lume ? [.isSelected] : [])
        }
      }
    }
    .scrollIndicators(.hidden)
    .frame(maxWidth: .infinity)
  }
}
