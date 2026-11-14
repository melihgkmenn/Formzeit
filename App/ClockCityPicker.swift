import SwiftUI

struct ClockCityPicker: View {
  var title: LocalizedStringResource
  @Binding var selection: ClockCity

  var body: some View {
    NavigationLink {
      ClockCityList(title: title, selection: $selection)
    } label: {
      HStack {
        Text(title).foregroundStyle(.primary)
        Spacer()
        Text(selection.title).foregroundStyle(.secondary)
      }
    }
    .accessibilityValue(Text(selection.title))
  }
}

private struct ClockCityList: View {
  var title: LocalizedStringResource
  @Binding var selection: ClockCity
  @State private var search = ""
  @Environment(\.locale) private var locale
  @Environment(\.dismiss) private var dismiss

  private var cities: [ClockCity] {
    ClockCity.allCases.filter { city in
      var name = city.title
      name.locale = locale
      return search.isEmpty || String(localized: name).localizedStandardContains(search)
        || city.timeZone.identifier.localizedStandardContains(search)
        || city.offset(at: .now).localizedStandardContains(search)
    }
  }

  var body: some View {
    List(cities) { city in
      Button {
        selection = city
        dismiss()
      } label: {
        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text(city.title).foregroundStyle(.primary)
            Text(city.timeZone.identifier).font(.caption).foregroundStyle(.secondary)
          }
          Spacer()
          Text(city.offset(at: .now)).font(.caption.monospaced()).foregroundStyle(.secondary)
          if selection == city { Image(systemName: "checkmark").font(.body.weight(.semibold)) }
        }
        .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      .accessibilityAddTraits(selection == city ? [.isSelected] : [])
    }
    .navigationTitle(Text(title))
    .searchable(text: $search, prompt: "Şehir ara")
    .overlay {
      if cities.isEmpty { ContentUnavailableView.search(text: search) }
    }
  }
}
