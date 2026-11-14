import Foundation

enum ClockMovement: String, CaseIterable, Identifiable {
  case mechanical, quartz, silent
  case digital
  static var selectable: [Self] { [.quartz, .mechanical, .digital] }
  var id: String { rawValue }
  var title: LocalizedStringResource {
    switch self {
    case .mechanical: "Mekanik"
    case .quartz: "Kuvars"
    case .silent: "Saniyesiz"
    case .digital: "Dijital"
    }
  }
  var interval: TimeInterval {
    switch self {
    case .mechanical: 1.0 / 15
    case .quartz: 1
    case .silent: 1
    case .digital: 1
    }
  }
  var showsSeconds: Bool { self == .mechanical || self == .quartz }
  var detail: LocalizedStringResource {
    switch self {
    case .mechanical: "Akrep, yelkovan ve saniye ibresi kesintisiz akar."
    case .quartz: "İbreler saniyede bir, net adımlarla ilerler."
    case .digital: "Akrep ve yelkovan dakikada bir ilerler. Saniye ibresi gizlenir."
    case .silent: "Akrep ve yelkovan ilerler; saniye ibresi görünmez."
    }
  }
}
