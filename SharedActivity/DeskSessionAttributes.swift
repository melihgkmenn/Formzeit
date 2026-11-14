import ActivityKit
import Foundation

struct DeskSessionAttributes: ActivityAttributes {
  struct ContentState: Codable, Hashable {
    var startedAt: Date
  }
  var title: String
  var languageCode: String?
}
