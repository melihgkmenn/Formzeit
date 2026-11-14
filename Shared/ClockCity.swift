import Foundation
import AppIntents

enum ClockCity: String, CaseIterable, Identifiable, Codable, AppEnum {
  case local
  case istanbul
  case zurich
  case london
  case paris
  case newYork
  case losAngeles
  case tokyo
  case singapore
  case sydney
  case delhi
  case kathmandu
  case utc
  case berlin
  case rome
  case madrid
  case lisbon
  case amsterdam
  case stockholm
  case oslo
  case copenhagen
  case helsinki
  case athens
  case warsaw
  case bucharest
  case moscow
  case reykjavik
  case dubai
  case riyadh
  case tehran
  case jerusalem
  case cairo
  case johannesburg
  case nairobi
  case lagos
  case casablanca
  case chicago
  case denver
  case toronto
  case vancouver
  case mexicoCity
  case saoPaulo
  case buenosAires
  case santiago
  case lima
  case bogota
  case honolulu
  case anchorage
  case shanghai
  case hongKong
  case taipei
  case seoul
  case bangkok
  case jakarta
  case manila
  case hanoi
  case dhaka
  case karachi
  case kabul
  case yangon
  case adelaide
  case perth
  case auckland
  case chatham
  case suva
  var id: String { rawValue }
  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Şehir")
  static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
    .local: "Yerel saat",
    .istanbul: "İstanbul",
    .zurich: "Zürih",
    .london: "Londra",
    .paris: "Paris",
    .newYork: "New York",
    .losAngeles: "Los Angeles",
    .tokyo: "Tokyo",
    .singapore: "Singapur",
    .sydney: "Sidney",
    .delhi: "Yeni Delhi",
    .kathmandu: "Katmandu",
    .utc: "UTC",
    .berlin: "Berlin",
    .rome: "Roma",
    .madrid: "Madrid",
    .lisbon: "Lizbon",
    .amsterdam: "Amsterdam",
    .stockholm: "Stockholm",
    .oslo: "Oslo",
    .copenhagen: "Kopenhag",
    .helsinki: "Helsinki",
    .athens: "Atina",
    .warsaw: "Varşova",
    .bucharest: "Bükreş",
    .moscow: "Moskova",
    .reykjavik: "Reykjavik",
    .dubai: "Dubai",
    .riyadh: "Riyad",
    .tehran: "Tahran",
    .jerusalem: "Kudüs",
    .cairo: "Kahire",
    .johannesburg: "Johannesburg",
    .nairobi: "Nairobi",
    .lagos: "Lagos",
    .casablanca: "Kazablanka",
    .chicago: "Chicago",
    .denver: "Denver",
    .toronto: "Toronto",
    .vancouver: "Vancouver",
    .mexicoCity: "Meksiko",
    .saoPaulo: "São Paulo",
    .buenosAires: "Buenos Aires",
    .santiago: "Santiago",
    .lima: "Lima",
    .bogota: "Bogotá",
    .honolulu: "Honolulu",
    .anchorage: "Anchorage",
    .shanghai: "Şanghay",
    .hongKong: "Hong Kong",
    .taipei: "Taipei",
    .seoul: "Seul",
    .bangkok: "Bangkok",
    .jakarta: "Cakarta",
    .manila: "Manila",
    .hanoi: "Hanoi",
    .dhaka: "Dakka",
    .karachi: "Karaçi",
    .kabul: "Kabil",
    .yangon: "Yangon",
    .adelaide: "Adelaide",
    .perth: "Perth",
    .auckland: "Auckland",
    .chatham: "Chatham",
    .suva: "Suva",
  ]
  var title: LocalizedStringResource {
    switch self {
    case .local: "Yerel saat"
    case .istanbul: "İstanbul"
    case .zurich: "Zürih"
    case .london: "Londra"
    case .paris: "Paris"
    case .newYork: "New York"
    case .losAngeles: "Los Angeles"
    case .tokyo: "Tokyo"
    case .singapore: "Singapur"
    case .sydney: "Sidney"
    case .delhi: "Yeni Delhi"
    case .kathmandu: "Katmandu"
    case .utc: "UTC"
    case .berlin: "Berlin"
    case .rome: "Roma"
    case .madrid: "Madrid"
    case .lisbon: "Lizbon"
    case .amsterdam: "Amsterdam"
    case .stockholm: "Stockholm"
    case .oslo: "Oslo"
    case .copenhagen: "Kopenhag"
    case .helsinki: "Helsinki"
    case .athens: "Atina"
    case .warsaw: "Varşova"
    case .bucharest: "Bükreş"
    case .moscow: "Moskova"
    case .reykjavik: "Reykjavik"
    case .dubai: "Dubai"
    case .riyadh: "Riyad"
    case .tehran: "Tahran"
    case .jerusalem: "Kudüs"
    case .cairo: "Kahire"
    case .johannesburg: "Johannesburg"
    case .nairobi: "Nairobi"
    case .lagos: "Lagos"
    case .casablanca: "Kazablanka"
    case .chicago: "Chicago"
    case .denver: "Denver"
    case .toronto: "Toronto"
    case .vancouver: "Vancouver"
    case .mexicoCity: "Meksiko"
    case .saoPaulo: "São Paulo"
    case .buenosAires: "Buenos Aires"
    case .santiago: "Santiago"
    case .lima: "Lima"
    case .bogota: "Bogotá"
    case .honolulu: "Honolulu"
    case .anchorage: "Anchorage"
    case .shanghai: "Şanghay"
    case .hongKong: "Hong Kong"
    case .taipei: "Taipei"
    case .seoul: "Seul"
    case .bangkok: "Bangkok"
    case .jakarta: "Cakarta"
    case .manila: "Manila"
    case .hanoi: "Hanoi"
    case .dhaka: "Dakka"
    case .karachi: "Karaçi"
    case .kabul: "Kabil"
    case .yangon: "Yangon"
    case .adelaide: "Adelaide"
    case .perth: "Perth"
    case .auckland: "Auckland"
    case .chatham: "Chatham"
    case .suva: "Suva"
    }
  }
  var timeZone: TimeZone {
    let identifier: String
    switch self {
    case .local: return .autoupdatingCurrent
    case .istanbul: identifier = "Europe/Istanbul"
    case .zurich: identifier = "Europe/Zurich"
    case .london: identifier = "Europe/London"
    case .paris: identifier = "Europe/Paris"
    case .newYork: identifier = "America/New_York"
    case .losAngeles: identifier = "America/Los_Angeles"
    case .tokyo: identifier = "Asia/Tokyo"
    case .singapore: identifier = "Asia/Singapore"
    case .sydney: identifier = "Australia/Sydney"
    case .delhi: identifier = "Asia/Kolkata"
    case .kathmandu: identifier = "Asia/Kathmandu"
    case .utc: identifier = "UTC"
    case .berlin: identifier = "Europe/Berlin"
    case .rome: identifier = "Europe/Rome"
    case .madrid: identifier = "Europe/Madrid"
    case .lisbon: identifier = "Europe/Lisbon"
    case .amsterdam: identifier = "Europe/Amsterdam"
    case .stockholm: identifier = "Europe/Stockholm"
    case .oslo: identifier = "Europe/Oslo"
    case .copenhagen: identifier = "Europe/Copenhagen"
    case .helsinki: identifier = "Europe/Helsinki"
    case .athens: identifier = "Europe/Athens"
    case .warsaw: identifier = "Europe/Warsaw"
    case .bucharest: identifier = "Europe/Bucharest"
    case .moscow: identifier = "Europe/Moscow"
    case .reykjavik: identifier = "Atlantic/Reykjavik"
    case .dubai: identifier = "Asia/Dubai"
    case .riyadh: identifier = "Asia/Riyadh"
    case .tehran: identifier = "Asia/Tehran"
    case .jerusalem: identifier = "Asia/Jerusalem"
    case .cairo: identifier = "Africa/Cairo"
    case .johannesburg: identifier = "Africa/Johannesburg"
    case .nairobi: identifier = "Africa/Nairobi"
    case .lagos: identifier = "Africa/Lagos"
    case .casablanca: identifier = "Africa/Casablanca"
    case .chicago: identifier = "America/Chicago"
    case .denver: identifier = "America/Denver"
    case .toronto: identifier = "America/Toronto"
    case .vancouver: identifier = "America/Vancouver"
    case .mexicoCity: identifier = "America/Mexico_City"
    case .saoPaulo: identifier = "America/Sao_Paulo"
    case .buenosAires: identifier = "America/Argentina/Buenos_Aires"
    case .santiago: identifier = "America/Santiago"
    case .lima: identifier = "America/Lima"
    case .bogota: identifier = "America/Bogota"
    case .honolulu: identifier = "Pacific/Honolulu"
    case .anchorage: identifier = "America/Anchorage"
    case .shanghai: identifier = "Asia/Shanghai"
    case .hongKong: identifier = "Asia/Hong_Kong"
    case .taipei: identifier = "Asia/Taipei"
    case .seoul: identifier = "Asia/Seoul"
    case .bangkok: identifier = "Asia/Bangkok"
    case .jakarta: identifier = "Asia/Jakarta"
    case .manila: identifier = "Asia/Manila"
    case .hanoi: identifier = "Asia/Ho_Chi_Minh"
    case .dhaka: identifier = "Asia/Dhaka"
    case .karachi: identifier = "Asia/Karachi"
    case .kabul: identifier = "Asia/Kabul"
    case .yangon: identifier = "Asia/Yangon"
    case .adelaide: identifier = "Australia/Adelaide"
    case .perth: identifier = "Australia/Perth"
    case .auckland: identifier = "Pacific/Auckland"
    case .chatham: identifier = "Pacific/Chatham"
    case .suva: identifier = "Pacific/Fiji"
    }
    return TimeZone(identifier: identifier) ?? .gmt
  }
  func offset(at date: Date) -> String {
    let minutes = timeZone.secondsFromGMT(for: date) / 60
    return "UTC\(minutes >= 0 ? "+" : "−")\(abs(minutes) / 60)" + (abs(minutes) % 60 == 0 ? "" : String(format: ":%02d", abs(minutes) % 60))
  }
  func time(_ date: Date, locale: Locale = .autoupdatingCurrent) -> String {
    let format = Date.VerbatimFormatStyle(
      format: "\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits)",
      locale: locale, timeZone: timeZone, calendar: Calendar(identifier: .gregorian)
    )
    return date.formatted(format)
  }
  func dayLabel(_ date: Date, locale: Locale = .autoupdatingCurrent) -> String {
    var format = Date.FormatStyle.dateTime.day().month(.abbreviated).weekday(.abbreviated)
    format.timeZone = timeZone
    format.locale = locale
    return date.formatted(format)
  }
}
