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
        SimpleEntry(date: Date(), quote: "What you think, you become", imagePath: nil, solidColor: nil, textSize: 20, textColor: 0xFF2F3A4B, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "Think big, have big", imagePath: nil, solidColor: nil, textSize: 20, textColor: 0xFF2F3A4B, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let (quote, imagePath, textSize, textColor, solidColor) = loadValues()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quote: quote, imagePath: imagePath, solidColor: solidColor, textSize: textSize, textColor: textColor, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(3600)))
    }
    private func loadValues() -> (String, String?, Int?, Int?, Int?) {
            let userDefaults = UserDefaults(suiteName: "group.com.abdulmuiz.sureline.quoteWidget")
        let quote = getRandomStringFromUserDefaultsArray(appGroupID: "group.com.abdulmuiz.sureline.quoteWidget", key: "quotes_data_app_group",maxLength: 50) ?? "Never give up"
            let imagePath = userDefaults?.string(forKey: "image_path_app_group")
            let textSize = userDefaults?.integer(forKey: "text_size_app_group")
            let textColor = userDefaults?.integer(forKey: "text_color_app_group")
            let solidColor = userDefaults?.integer(forKey: "solid_color_app_group")
            return (quote, imagePath, textSize, textColor, solidColor)
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
    let imagePath: String?
    let solidColor: Int?
    let textSize: Int?
    let textColor: Int?
    let configuration: ConfigurationAppIntent
}

extension Color {
    init(argb: Int) {
        let a = Double((argb >> 24) & 0xFF) / 255.0
        let r = Double((argb >> 16) & 0xFF) / 255.0
        let g = Double((argb >> 8) & 0xFF) / 255.0
        let b = Double(argb & 0xFF) / 255.0

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}


struct SurelineQuoteLockWidgetEntryView: View {
    
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
            .multilineTextAlignment(.leading)
            .containerBackground(for: .widget) {
                    Image("background2Widget")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
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

struct SurelineQuoteLockWidget: Widget {
    let kind: String = "SurelineQuoteLockWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            SurelineQuoteLockWidgetEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.accessoryRectangular])
        .configurationDisplayName("Quotes")
        .description("Read quotes to get positive energy on your Lock screen.")
            
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
    SurelineQuoteLockWidget()
} timeline: {
    SimpleEntry(date: .now, quote: "Never give up", imagePath: nil, solidColor: nil, textSize: 20, textColor: 0xFF2F3A4B,configuration: .smiley)
}
