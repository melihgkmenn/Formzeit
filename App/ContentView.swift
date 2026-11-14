import SwiftUI
import WidgetKit

struct ContentView: View {
  @State private var settings = ClockSettings()
  @State private var selection = 0
  @State private var showSettings = false
  @State private var fullScreen = false
  @State private var dismissLandscape = false
  @AppStorage("openClockRequested") private var openClockRequested = false
  @Environment(\.colorScheme) private var colorScheme

  private var night: Bool { settings.isNight(system: colorScheme) }

  var body: some View {
    GeometryReader { geometry in
      let landscape = geometry.size.width > geometry.size.height * 1.2
      let autoFullScreen = automaticFullScreen && landscape && !dismissLandscape
      Group {
        if fullScreen || autoFullScreen {
          ImmersiveClockView(settings: settings, night: night) {
            fullScreen = false
            dismissLandscape = true
          }
        } else {
          TabView(selection: $selection) {
            Tab("Saat", systemImage: "clock.fill", value: 0) {
              NavigationStack {
                ClockStudioView(settings: settings, night: night, fullScreen: $fullScreen)
                  .navigationTitle("Formzeit")
                  #if os(iOS)
                  .navigationBarTitleDisplayMode(.inline)
                  #endif
                  .toolbar {
                    ToolbarItem(placement: .principal) {
                      Text("Formzeit").font(.headline)
                        .foregroundStyle(FormzeitBrand.color(onDark: night))
                        .accessibilityAddTraits(.isHeader)
                    }
                    ToolbarItemGroup(placement: .primaryAction) {
                      Button(night ? LocalizedStringResource("Gündüz modu") : "Gece modu", systemImage: night ? "sun.max.fill" : "moon.fill") {
                        settings.appearance = night ? .day : .night
                      }
                      Button("Ayarlar", systemImage: "gearshape") { showSettings = true }
                    }
                  }
              }
            }
            Tab("Kadranlar", systemImage: "circle.lefthalf.filled", value: 1) {
              NavigationStack {
                DialGalleryView(settings: settings, night: night)
                  .navigationTitle("Kadranlar")
              }
            }
            Tab("Widget’lar", systemImage: "square.grid.2x2", value: 2) {
              NavigationStack {
                WidgetGuideView(style: settings.style, secondStyle: settings.secondStyle)
                  .navigationTitle("Her yerde, seninle.")
              }
            }
          }
          .tint(night ? settings.lume.color : Color(hex: 0x3E5643))
        }
      }
      .background(night ? Color(hex: 0x0C1210) : Color(hex: 0xF5F3EC))
      .preferredColorScheme(settings.appearance == .system ? nil : (night ? .dark : .light))
      .sheet(isPresented: $showSettings) {
        NavigationStack { ClockSettingsView(settings: settings) }
          .presentationDetents([.large])
      }
      .onChange(of: landscape) { _, _ in dismissLandscape = false }
      .onChange(of: openClockRequested) { _, requested in
        if requested { openRequestedClock() }
      }
      .onAppear {
        if openClockRequested { openRequestedClock() }
        #if os(macOS)
        WidgetCenter.shared.reloadTimelines(ofKind: "Formzeit.Clock")
        #endif
      }
      .onOpenURL { url in
        guard url.scheme == "formzeit" else { return }
        selection = 0
        if url.host == "night" { settings.appearance = .night; fullScreen = true }
        else if url.host == "clock" { fullScreen = true }
      }
      .onReceive(NotificationCenter.default.publisher(for: .NSSystemTimeZoneDidChange)) { _ in
        WidgetCenter.shared.reloadAllTimelines()
      }
    }
    .environment(\.locale, settings.language.locale)
    .environment(\.layoutDirection, settings.language.layoutDirection)
  }

  private var automaticFullScreen: Bool {
    #if os(iOS)
    settings.landscapeFullScreen
    #else
    false
    #endif
  }

  private func openRequestedClock() {
    selection = 0
    fullScreen = true
    openClockRequested = false
  }
}
