#if os(iOS)
import SwiftUI
import ActivityKit

struct ClockSessionSection: View {
  @State private var active = false
  @State private var allowed = ActivityAuthorizationInfo().areActivitiesEnabled
  @State private var errorMessage: String?
  @Environment(\.locale) private var locale
  var body: some View {
    Section {
      if allowed {
        Button(active ? LocalizedStringResource("Oturumu bitir") : "Canlı oturumu başlat", systemImage: "timer") {
          Task {
            if active {
              for activity in Activity<DeskSessionAttributes>.activities {
                await activity.end(nil, dismissalPolicy: .immediate)
              }
              active = false
            } else {
              do {
                let attributes = DeskSessionAttributes(title: "Masa saati", languageCode: locale.identifier)
                _ = try Activity.request(attributes: attributes, content: ActivityContent(state: DeskSessionAttributes.ContentState(startedAt: .now), staleDate: nil), pushType: nil)
                active = true
              } catch { errorMessage = error.localizedDescription }
            }
          }
        }
      } else {
        Text("Canlı Etkinlikler sistem ayarlarında kapalı.").foregroundStyle(.secondary)
      }
    } header: { Text("Canlı Etkinlik") } footer: {
      Text("Oturum süreni Kilit Ekranı ve Dynamic Island’da gör. İşin bittiğinde oturumu buradan bitir.")
    }
    .task {
      active = !Activity<DeskSessionAttributes>.activities.isEmpty
      for await enabled in ActivityAuthorizationInfo().activityEnablementUpdates { allowed = enabled }
    }
    .alert("Oturum başlatılamadı", isPresented: Binding(get: { errorMessage != nil }, set: { if !$0 { errorMessage = nil } })) {
      Button("Tamam") { errorMessage = nil }
    } message: { Text(errorMessage ?? "") }
  }
}
#endif
