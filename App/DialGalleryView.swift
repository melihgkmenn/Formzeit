import SwiftUI

struct DialGalleryView: View {
  @Bindable var settings: ClockSettings
  var night: Bool
  @State private var editingClock: ClockSlot = .primary
  private var selectedStyle: Binding<DialStyle> { editingClock == .primary ? $settings.style : $settings.secondStyle }
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("Rengini bul.").font(.system(.largeTitle, design: .serif))
        Text("20 ton. Tek bir zamansız form.").foregroundStyle(.secondary)
        if settings.dual {
          Picker("Kadranı düzenle", selection: $editingClock) {
            ForEach(ClockSlot.allCases) { Text($0.title).tag($0) }
          }
          .pickerStyle(.segmented)
        }
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 145, maximum: 240), spacing: 16)], spacing: 24) {
          ForEach(DialStyle.allCases) { style in
            Button {
              selectedStyle.wrappedValue = style
            } label: {
              VStack(alignment: .leading, spacing: 13) {
                AnalogDial(date: Date(timeIntervalSince1970: 36636), style: style, city: .utc, night: false, movement: .quartz)
                  .padding(12)
                  .background(style.color.opacity(0.14), in: RoundedRectangle(cornerRadius: 24))
                HStack {
                  Text(style.title).font(.subheadline.weight(.medium))
                  Spacer()
                  if selectedStyle.wrappedValue == style { Image(systemName: "checkmark").font(.caption.weight(.bold)) }
                }
                .foregroundStyle(.primary)
              }
              .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Text("\(Text(style.title)) kadranı seç"))
            .accessibilityAddTraits(style == selectedStyle.wrappedValue ? [.isSelected] : [])
          }
        }
      }
      .padding(24)
      .frame(maxWidth: 1050)
      .frame(maxWidth: .infinity)
    }
    .background(night ? Color(hex: 0x0C1210) : Color(hex: 0xF5F3EC))
    .onChange(of: settings.dual) { _, dual in if !dual { editingClock = .primary } }
  }
}
