import SwiftUI

struct ImmersiveClockView: View {
  @Bindable var settings: ClockSettings
  var night: Bool
  var close: () -> Void
  @State private var controlsVisible = true
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.scenePhase) private var scenePhase
  private var movement: ClockMovement { reduceMotion && settings.movement == .mechanical ? .quartz : settings.movement }

  var body: some View {
    Group {
      #if os(iOS)
      if #available(iOS 27.1, *) {
        ArrangementView {
          controls
        } secondary: {
          clocks
        }
        .arrangementViewStyle(.overlay)
      } else {
        clocks.overlay { controls }
      }
      #else
      clocks.overlay { controls }
      #endif
    }
    .background(night ? Color.black : settings.style.color)
    .contentShape(Rectangle())
    .onTapGesture { controlsVisible.toggle() }
    .accessibilityAction(named: controlsVisible ? Text("Kontrolleri gizle") : Text("Kontrolleri göster")) { controlsVisible.toggle() }
    .modifier(KeepClockAwake(enabled: settings.keepAwake))
    #if os(iOS)
    .statusBarHidden(true)
    .persistentSystemOverlays(.hidden)
    #endif
  }

  private var clocks: some View {
    GeometryReader { geometry in
      TimelineView(.animation(minimumInterval: movement.interval, paused: scenePhase != .active)) { context in
        let layout = geometry.size.width > geometry.size.height ? AnyLayout(HStackLayout(spacing: 24)) : AnyLayout(VStackLayout(spacing: 24))
        layout {
          AnalogDial(date: context.date, style: settings.style, city: settings.primaryCity, night: night, movement: movement, showSeconds: settings.showSeconds, lume: settings.lume.color)
          if settings.dual {
            AnalogDial(date: context.date, style: settings.secondStyle, city: settings.secondCity, night: night, movement: movement, showSeconds: settings.showSeconds, lume: settings.secondLume.color)
          }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotationEffect(.degrees(settings.inverted ? 180 : 0))
      }
    }
  }

  private var controls: some View {
    VStack {
      HStack {
        Button("Tam ekrandan çık", systemImage: "arrow.down.right.and.arrow.up.left", action: close)
          .keyboardShortcut(.escape, modifiers: [])
        Spacer()
        Button(night ? LocalizedStringResource("Gündüz") : "Gece", systemImage: night ? "sun.max.fill" : "moon.fill") {
          settings.appearance = night ? .day : .night
        }
      }
      Spacer()
      HStack(spacing: 16) {
        if night {
          Picker("Gece fosforu", selection: $settings.lume) {
            ForEach(LumeColor.allCases) { Text($0.title).tag($0) }
          }
          .pickerStyle(.menu)
        }
        Toggle("Çift saat", isOn: $settings.dual)
        Toggle("180° çevir", isOn: $settings.inverted)
      }
      .toggleStyle(.button)
      .font(.subheadline)
    }
    .labelStyle(.iconOnly)
    .buttonStyle(.bordered)
    .tint(night ? settings.lume.color : settings.style.ink)
    .padding(20)
    .opacity(controlsVisible ? 1 : 0)
    .allowsHitTesting(controlsVisible)
    .accessibilityHidden(!controlsVisible)
  }
}

private struct KeepClockAwake: ViewModifier {
  var enabled: Bool
  func body(content: Content) -> some View {
    content
      #if os(iOS)
      .onAppear { UIApplication.shared.isIdleTimerDisabled = enabled }
      .onChange(of: enabled) { _, value in UIApplication.shared.isIdleTimerDisabled = value }
      .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
      #endif
  }
}
