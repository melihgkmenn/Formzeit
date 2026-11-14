import WidgetKit
import AppIntents
import SwiftUI

struct ClockControl: ControlWidget {
  var body: some ControlWidgetConfiguration {
    StaticControlConfiguration(kind: "app.bitrig.new.8a945682-55a5-4dce-bb90-fc7140a8fd5f.control.open-clock") {
      ControlWidgetButton(action: LaunchClockIntent()) {
        Label("Formzeit", systemImage: "clock.fill")
      }
    }
    .displayName("Formzeit’i aç")
    .description("Masa saatine tek dokunuşla ulaş.")
  }
}
