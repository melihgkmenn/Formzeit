import SwiftUI

struct ClockStudioView: View {
  @Bindable var settings: ClockSettings
  var night: Bool
  @Binding var fullScreen: Bool
  @State private var editingClock: ClockSlot = .primary
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.scenePhase) private var scenePhase
  @Environment(\.locale) private var locale
  private var movement: ClockMovement { reduceMotion && settings.movement == .mechanical ? .quartz : settings.movement }
  private var selectedStyle: Binding<DialStyle> { editingClock == .primary ? $settings.style : $settings.secondStyle }
  private var selectedLume: Binding<LumeColor> { editingClock == .primary ? $settings.lume : $settings.secondLume }

  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        ViewThatFits(in: .horizontal) {
          HStack(alignment: .center, spacing: 48) {
            clockPanel.frame(minWidth: 380, maxWidth: 610)
            selectionPanel.frame(width: 300)
          }
          VStack(spacing: 26) {
            clockPanel
            selectionPanel
          }
        }
        .frame(maxWidth: 1080)
        .padding(.horizontal, geometry.size.width > 650 ? 40 : 24)
        .padding(.top, 18)
        .padding(.bottom, 30)
        .frame(maxWidth: .infinity)
      }
      .scrollIndicators(.hidden)
      .background(night ? Color(hex: 0x0C1210) : Color(hex: 0xF5F3EC))
    }
  }

  private var clockPanel: some View {
    VStack(spacing: 22) {
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 6) {
          Text("ZAMANA BİR BİÇİM.")
            .font(.system(.caption2, design: .monospaced, weight: .medium))
            .tracking(2.5)
            .foregroundStyle(.secondary)
          Text("Her an, yerinde.")
            .font(.system(.title2, design: .serif, weight: .medium))
        }
        Spacer()
        HStack(spacing: 6) {
          Circle().fill(night ? settings.lume.color : Color(hex: 0x557760)).frame(width: 5, height: 5)
          Text(night ? LocalizedStringResource("GECE") : "CANLI").font(.system(.caption2, design: .monospaced, weight: .medium)).tracking(1)
        }
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(.primary.opacity(0.045), in: Capsule())
      }
      TimelineView(.animation(minimumInterval: movement.interval, paused: scenePhase != .active)) { context in
        VStack(spacing: 19) {
          if settings.dual {
            HStack(spacing: 14) {
              AnalogDial(date: context.date, style: settings.style, city: settings.primaryCity, night: night, movement: movement, showSeconds: settings.showSeconds, lume: settings.lume.color)
              AnalogDial(date: context.date, style: settings.secondStyle, city: settings.secondCity, night: night, movement: movement, showSeconds: settings.showSeconds, lume: settings.secondLume.color)
            }
            HStack {
              cityLabel(settings.primaryCity, date: context.date)
              Spacer()
              cityLabel(settings.secondCity, date: context.date)
            }
          } else {
            AnalogDial(date: context.date, style: settings.style, city: settings.primaryCity, night: night, movement: movement, showSeconds: settings.showSeconds, lume: settings.lume.color)
              .padding(10)
              .background(settings.style.color.opacity(night ? 0.025 : 0.1), in: Circle())
            HStack(alignment: .center) {
              cityLabel(settings.primaryCity, date: context.date)
              Spacer()
              VStack(alignment: .trailing, spacing: 5) {
                Text(settings.primaryCity.dayLabel(context.date, locale: locale))
                  .font(.subheadline)
                Text(settings.primaryCity.offset(at: context.date))
                  .font(.system(.caption2, design: .monospaced))
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
      }
      Divider().opacity(0.6)
    }
    .frame(maxWidth: .infinity)
  }

  private var selectionPanel: some View {
    VStack(alignment: .leading, spacing: 22) {
      if settings.dual {
        Picker("Kadranı düzenle", selection: $editingClock) {
          ForEach(ClockSlot.allCases) { Text($0.title).tag($0) }
        }
        .pickerStyle(.segmented)
      }
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("KADRAN KOLEKSİYONU").font(.system(.caption2, design: .monospaced)).tracking(1.7).foregroundStyle(.secondary)
          Text(selectedStyle.wrappedValue.title).font(.system(.title2, design: .serif, weight: .medium))
        }
        Spacer()
        Text(String(format: "%02d / %02d", (DialStyle.allCases.firstIndex(of: selectedStyle.wrappedValue) ?? 0) + 1, DialStyle.allCases.count))
          .font(.system(.caption, design: .monospaced)).foregroundStyle(.secondary)
      }
      DialPalette(selection: selectedStyle)
      Text(selectedStyle.wrappedValue.subtitle).font(.subheadline).foregroundStyle(.secondary)
      if night {
        VStack(alignment: .leading, spacing: 8) {
          Text("GECE FOSFORU").font(.system(.caption2, design: .monospaced)).tracking(1.7).foregroundStyle(.secondary)
          LumePalette(selection: selectedLume)
          Text(selectedLume.wrappedValue.title).font(.caption).foregroundStyle(selectedLume.wrappedValue.color)
        }
      }
      Picker("Görünüm", selection: $settings.appearance) {
        ForEach(ClockAppearance.allCases) { Text($0.title).tag($0) }
      }
      .pickerStyle(.segmented)
      HStack {
        Label(settings.movement.title, systemImage: "clock.fill")
          .font(.caption).foregroundStyle(.secondary)
        Spacer()
        Toggle("Çift saat", isOn: $settings.dual)
          .toggleStyle(.button).buttonStyle(.bordered)
          .font(.caption)
      }
      Button {
        fullScreen = true
      } label: {
        HStack {
          Label("Tam ekrana geç", systemImage: "arrow.up.left.and.arrow.down.right")
          Spacer()
          Text("01:01").font(.system(.caption, design: .monospaced)).opacity(0.5).accessibilityHidden(true)
        }
        .font(.subheadline.weight(.medium))
        .padding(18)
        .foregroundStyle(night ? Color(hex: 0x132219) : Color(hex: 0xF7F5ED))
        .background(night ? settings.lume.color : Color(hex: 0x293D30), in: RoundedRectangle(cornerRadius: 17))
      }
      .buttonStyle(.plain)
      HStack(spacing: 7) {
        Rectangle().fill(settings.style.color).frame(width: 18, height: 3)
        Text("İYİ TASARIM. SADECE ZAMAN.")
          .font(.system(size: 9, weight: .medium, design: .monospaced)).tracking(1.5)
          .foregroundStyle(.secondary)
      }
      .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity)
    .onChange(of: settings.dual) { _, dual in if !dual { editingClock = .primary } }
  }

  private func cityLabel(_ city: ClockCity, date: Date) -> some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(city.title).font(.system(.subheadline, weight: .medium))
      Text(city.time(date, locale: locale)).font(.system(.title3, design: .monospaced, weight: .regular)).monospacedDigit()
    }
  }
}
