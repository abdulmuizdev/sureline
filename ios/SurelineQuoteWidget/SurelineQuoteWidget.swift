//
//  SurelineQuoteWidget.swift
//  SurelineQuoteWidget
//
//  Created by Abdul Muiz on 21/05/2025.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "What you thing, you become", imageAsset: nil, solidColor: nil, textSize: 20, textColor: "2F3A4B", configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "Think big, have big", imageAsset: nil, solidColor: nil, textSize: 20, textColor: "2F3A4B", configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let (quote, imageAsset, textSize, textColor, solidColor) = loadValues()

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: quote, imageAsset: imageAsset, solidColor: solidColor, textSize: textSize, textColor: textColor, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(3600)))
    }
    private func loadValues() -> (String, String?, Int?, String?, String?) {
            let userDefaults = UserDefaults(suiteName: "group.com.abdulmuiz.sureline.quoteWidget")
        let quote = getRandomStringFromUserDefaultsArray(appGroupID: "group.com.abdulmuiz.sureline.quoteWidget", key: "quotes_data_app_group") ?? "Never give up"
            let imageAsset = userDefaults?.string(forKey: "image_asset_app_group")
            let textSize = userDefaults?.integer(forKey: "text_size_app_group")
            let textColor = userDefaults?.string(forKey: "text_color_app_group")
            let solidColor: String?
            if (userDefaults?.object(forKey: "solid_color_app_group") == nil){
                solidColor = nil
            }else {
                solidColor = userDefaults?.string(forKey: "solid_color_app_group") as? String
            }

            return (quote, imageAsset, textSize, textColor, solidColor)
        }


    private func getRandomStringFromUserDefaultsArray(appGroupID: String, key: String, maxLength: Int? = nil) -> String? {
        guard let userDefaults = UserDefaults(suiteName: appGroupID),
              let array = userDefaults.stringArray(forKey: key),
              !array.isEmpty else {
            return nil
        }

        let filteredArray: [String]
        if let maxLength = maxLength {
            filteredArray = array.filter { $0.count <= maxLength }
        } else {
            filteredArray = array
        }

        return filteredArray.randomElement()
    }



}

struct SimpleEntry : TimelineEntry{
    let date: Date
    let quote: String
    let imageAsset: String?
    let solidColor: String?
    let textSize: Int?
    let textColor: String?
    let configuration: ConfigurationAppIntent
}

//extension Color {
//    init(argb: Int) {
//        let a = Double((argb >> 24) & 0xFF) / 255.0
//        let r = Double((argb >> 16) & 0xFF) / 255.0
//        let g = Double((argb >> 8) & 0xFF) / 255.0
//        let b = Double(argb & 0xFF) / 255.0
//
//        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
//    }
//}


struct SurelineQuoteWidgetEntryView: View {

        @Environment(\.widgetFamily) var family
        var entry: Provider.Entry

        var body: some View {
            switch family {
            case .systemSmall:
                SmallWidgetView(entry: entry)
            case .systemMedium:
                SmallWidgetView(entry: entry)
            case .systemLarge:
                SmallWidgetView(entry: entry)
            case .accessoryRectangular:
                SmallWidgetView(entry: entry)
            case .accessoryInline:
                SmallWidgetView(entry: entry)
            case .accessoryCircular:
                SmallWidgetView(entry: entry)
            default:
                SmallWidgetView(entry: entry)
            }
        }

}
struct SmallWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.quote)
//            .font(.system(size: CGFloat(entry.textSize ?? 14)))
//            .foregroundColor(Color(argb: entry.textColor!))
            .foregroundColor(colorFromHexString(entry.textColor))
            .multilineTextAlignment(.center)
            .containerBackground(for: .widget) {
                Group {

                    if let solidColor = entry.solidColor {
                        colorFromHexString(entry.solidColor).ignoresSafeArea()
                    }else {
                        Image(entry.imageAsset ?? "background2Widget")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }

            }
    }
}

private func colorFromHex(_ hex: Int?) -> Color? {
    guard let hex = hex else { return nil }
    let red = Double((hex >> 16) & 0xFF) / 255.0
    let green = Double((hex >> 8) & 0xFF) / 255.0
    let blue = Double(hex & 0xFF) / 255.0
    return Color(red: red, green: green, blue: blue)
}

func colorFromHexString(_ hexString: String?) -> Color? {
    guard let hexString = hexString,
          let rgb = Int(hexString, radix: 16) else { return nil }
    let argb = 0xFF000000 | rgb
    return colorFromHex(argb)
}


struct SurelineQuoteWidget: Widget {
    let kind: String = "SurelineQuoteWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            SurelineQuoteWidgetEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemMedium, .systemLarge, .systemSmall, .systemExtraLarge])

        .configurationDisplayName("Hourly quotes")
        .description("Make it yours by editing this widget from app's widget setting")

    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "Standard"
        return intent
    }
}

#Preview(as: .systemSmall) {
    SurelineQuoteWidget()
} timeline: {
    SimpleEntry(date: .now, quote: "Never give up", imageAsset: nil, solidColor: nil, textSize: 20, textColor: "2F3A4B",configuration: .smiley)
}
