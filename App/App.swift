import SwiftUI

@main
struct AppDefinition: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        #if os(macOS)
        .frame(minWidth: 420, minHeight: 580)
        #endif
    }
    #if os(macOS)
    .defaultSize(width: 1000, height: 780)
    #endif
  }
}
