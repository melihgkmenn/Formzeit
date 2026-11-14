import SwiftUI

struct ContentView: View {
  @AppStorage("watchDial") private var style: DialStyle = .solar
  @AppStorage("watchNight") private var night = false
  @AppStorage("watchCity") private var city: ClockCity = .local
  @AppStorage("watchLume") private var lume: LumeColor = .mint
  @AppStorage("watchLanguage") private var language: AppLanguage = .system
  @AppStorage("watchMovement") private var movement: ClockMovement = .quartz
  @AppStorage("watchShowSeconds") private var showSeconds = true
  @Environment(\.isLuminanceReduced) private var luminanceReduced
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.scenePhase) private var scenePhase
  @State private var settingsVisible = false
  private var activeMovement: ClockMovement { reduceMotion && movement == .mechanical ? .quartz : movement }
  var body: some View {
    TimelineView(.animation(minimumInterval: luminanceReduced ? 60 : activeMovement.interval, paused: scenePhase == .background)) { context in
      Button {
        settingsVisible = true
      } label: {
        AnalogDial(date: context.date, style: style, city: city, night: night || luminanceReduced, movement: luminanceReduced ? .silent : activeMovement, showBrand: false, showSeconds: showSeconds, lume: lume.color)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      .accessibilityHint("Saat ayarlarını açmak için dokun.")
    }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.black)
      .ignoresSafeArea()
      .sheet(isPresented: $settingsVisible) {
        NavigationStack {
          Form {
            Picker("Kadran", selection: $style) { ForEach(DialStyle.allCases) { Text($0.title).tag($0) } }
            Toggle("Gece modu", isOn: $night)
            Picker("Gece fosforu", selection: $lume) { ForEach(LumeColor.allCases) { Text($0.title).tag($0) } }
            Picker("Hareket", selection: $movement) { ForEach(ClockMovement.selectable) { Text($0.title).tag($0) } }
            if movement.showsSeconds { Toggle("Saniye ibresi", isOn: $showSeconds) }
            Picker("Şehir", selection: $city) { ForEach(ClockCity.allCases) { Text($0.title).tag($0) } }
            Picker("Uygulama dili", selection: $language) { ForEach(AppLanguage.allCases) { Text($0.title).tag($0) } }
          }
          .navigationTitle("Görünüm")
        }
      }
    .environment(\.locale, language.locale)
    .environment(\.layoutDirection, language.layoutDirection)
  }
}
