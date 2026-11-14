import SwiftUI

struct WidgetGuideView: View {
  var style: DialStyle
  var secondStyle: DialStyle
  @Environment(\.colorScheme) private var colorScheme
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 30) {
        Text("Bir bakış yeter.").font(.system(.largeTitle, design: .serif))
        Text("Ana ekranında, masanda, bileğinde. Zamanına kendi rengini ver.")
          .foregroundStyle(.secondary)
        HStack(spacing: 15) {
          AnalogDial(date: Date(timeIntervalSince1970: 36636), style: style, city: .utc, movement: .quartz)
          AnalogDial(date: Date(timeIntervalSince1970: 36636), style: secondStyle, city: .utc, night: true, movement: .quartz)
        }
        .padding(16)
        .background(Color(hex: 0x23372E), in: RoundedRectangle(cornerRadius: 28))
        VStack(alignment: .leading, spacing: 24) {
          guide("Kilit Ekranı", symbol: "clock.fill", text: "Kilit Ekranı’na basılı tut. Özelleştir › Kilit Ekranı › Widget Ekle › Formzeit. Dairesel, dikdörtgen veya satır içi saati seç.")
          Divider()
          guide("Ana ekran", symbol: "square.grid.2x2", text: "Ana ekrana basılı tut. Düzenle › Widget Ekle › Formzeit. Widget’a basılı tutup Widget’ı Düzenle ile renk, şehir ve gece görünümünü seç.")
          Divider()
          guide("Mac masaüstü", symbol: "display", text: "Masaüstüne sağ tıkla. Widget’ları Düzenle’den Formzeit’i ekle. Küçük, orta ve büyük boyutlar hazır.")
          Text("Mac’te sürekli renk: Sistem Ayarları › Masaüstü ve Dock › Araç Takımları › Soluklaştırma: Asla.")
            .font(.footnote).foregroundStyle(.secondary)
          Divider()
          guide("Apple Watch", symbol: "applewatch", text: "Saat kadranına basılı tut. Düzenle › Komplikasyonlar’dan Formzeit’i seç. Akıllı Gruplama’ya da ekleyebilirsin.")
          Divider()
          guide("Denetim Merkezi", symbol: "moon.fill", text: "Denetim Merkezi’ne basılı tut. Denetim Ekle’den Formzeit’i seç. Saat uygulamasına tek dokunuşla ulaş.")
        }
        .padding(24)
        .background(.primary.opacity(0.035), in: RoundedRectangle(cornerRadius: 24))
        Text("Widget tercihleri uygulamadan bağımsızdır. Her widget’a farklı renk ve şehir verebilirsin.")
          .font(.footnote).foregroundStyle(.secondary)
      }
      .padding(24)
      .frame(maxWidth: 700)
      .frame(maxWidth: .infinity)
    }
    .background(colorScheme == .dark ? Color(hex: 0x0C1210) : Color(hex: 0xF5F3EC))
  }
  private func guide(_ title: LocalizedStringResource, symbol: String, text: LocalizedStringResource) -> some View {
    HStack(alignment: .top, spacing: 16) {
      Image(systemName: symbol).font(.title3).frame(width: 28).foregroundStyle(Color(hex: 0x54735C))
      VStack(alignment: .leading, spacing: 7) {
        Text(title).font(.headline)
        Text(text).font(.subheadline).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
      }
    }
  }
}
