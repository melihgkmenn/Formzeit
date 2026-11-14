import SwiftUI

struct ClockSettingsView: View {
  @Bindable var settings: ClockSettings
  @Environment(\.dismiss) private var dismiss
  @Environment(\.locale) private var locale
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    Form {
      Section("Dil") {
        Picker("Uygulama dili", selection: $settings.language) {
          ForEach(AppLanguage.allCases) { Text($0.title).tag($0) }
        }
      }
      Section("Görünüm") {
        Picker("Birinci kadran", selection: $settings.style) {
          ForEach(DialStyle.allCases) { Text($0.title).tag($0) }
        }
        Picker("İkinci kadran", selection: $settings.secondStyle) {
          ForEach(DialStyle.allCases) { Text($0.title).tag($0) }
        }
        Picker("Mod", selection: $settings.appearance) {
          ForEach(ClockAppearance.allCases) { Text($0.title).tag($0) }
        }
        Picker("Gece fosforu", selection: $settings.lume) {
          ForEach(LumeColor.allCases) { Text($0.title).tag($0) }
        }
        Picker("İkinci saat gece fosforu", selection: $settings.secondLume) {
          ForEach(LumeColor.allCases) { Text($0.title).tag($0) }
        }
      }
      Section("Hareket") {
        MovementOptionsView(selection: $settings.movement, showSeconds: $settings.showSeconds)
      }
      Section("Dünya saatleri") {
        Toggle("Otomatik saat dilimi", isOn: $settings.followDeviceTimeZone)
        if settings.followDeviceTimeZone {
          TimelineView(.periodic(from: .now, by: 60)) { context in
            VStack(alignment: .leading, spacing: 5) {
              Text("Cihazın konuma göre güncellediği saat dilimi kullanılır.")
                .font(.footnote).foregroundStyle(.secondary)
              Text("\(TimeZone.autoupdatingCurrent.identifier) · \(ClockCity.local.offset(at: context.date))")
                .font(.caption.monospaced()).foregroundStyle(.secondary)
            }
          }
        } else {
          ClockCityPicker(title: "Birinci saat", selection: $settings.city)
        }
        Toggle("Çift saat", isOn: $settings.dual)
        ClockCityPicker(title: "İkinci saat", selection: $settings.secondCity)
      }
      Section {
        #if os(iOS)
        Toggle("Yatayda tam ekran", isOn: $settings.landscapeFullScreen)
        Toggle("Tam ekranda açık tut", isOn: $settings.keepAwake)
        #endif
        Toggle("Kadranı 180° çevir", isOn: $settings.inverted)
      } header: { Text("Masa saati") } footer: {
        Text("Tam ekranda dokunarak kontrolleri gizleyebilirsin. Duo’da katlandığında saat ve kontroller ayrı bölgelere yerleşir.")
      }
      #if os(iOS)
      ClockSessionSection()
      #endif
      Section {
        VStack(alignment: .leading, spacing: 6) {
          Text("FORMZEIT").font(.system(.headline, design: .monospaced)).tracking(3)
            .foregroundStyle(FormzeitBrand.color(onDark: colorScheme == .dark))
          Text("Biçim ve zaman. Her gün yeniden.").font(.subheadline).foregroundStyle(.secondary)
          Text("1.0").font(.caption).foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
      }
    }
    .formStyle(.grouped)
    .navigationTitle("Ayarlar")
    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Bitti", systemImage: "checkmark") { dismiss() } } }
    #if os(macOS)
    .frame(minWidth: 420, minHeight: 620)
    #endif
  }
}
