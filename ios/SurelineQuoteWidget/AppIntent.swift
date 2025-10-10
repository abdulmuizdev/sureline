//
//  AppIntent.swift
//  SurelineQuoteWidget
//
//  Created by Abdul Muiz on 21/05/2025.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "Make it yours by editing this widget from app's widget settings" }

    // An example configurable parameter.
    @Parameter(title: "Widgets", default: "Standard")
    var favoriteEmoji: String
}
