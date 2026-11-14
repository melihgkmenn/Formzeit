import SwiftUI

struct ClockReading: Equatable {
  var hour: Angle
  var minute: Angle
  var second: Angle

  init(date: Date, city: ClockCity, movement: ClockMovement) {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = city.timeZone
    let parts = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
    let seconds: Double
    switch movement {
    case .mechanical, .silent:
      seconds = Double(parts.second ?? 0) + Double(parts.nanosecond ?? 0) / 1_000_000_000
    case .quartz:
      seconds = Double(parts.second ?? 0)
    case .digital:
      seconds = 0
    }
    let minutes = Double(parts.minute ?? 0) + seconds / 60
    let hours = Double((parts.hour ?? 0) % 12) + minutes / 60
    hour = .degrees(hours * 30)
    minute = .degrees(minutes * 6)
    second = .degrees(seconds * 6)
  }
}
