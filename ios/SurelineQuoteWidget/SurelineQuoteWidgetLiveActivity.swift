//
//  SurelineQuoteWidgetLiveActivity.swift
//  SurelineQuoteWidget
//
//  Created by Abdul Muiz on 21/05/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SurelineQuoteWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SurelineQuoteWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SurelineQuoteWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SurelineQuoteWidgetAttributes {
    fileprivate static var preview: SurelineQuoteWidgetAttributes {
        SurelineQuoteWidgetAttributes(name: "World")
    }
}

extension SurelineQuoteWidgetAttributes.ContentState {
    fileprivate static var smiley: SurelineQuoteWidgetAttributes.ContentState {
        SurelineQuoteWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SurelineQuoteWidgetAttributes.ContentState {
         SurelineQuoteWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SurelineQuoteWidgetAttributes.preview) {
   SurelineQuoteWidgetLiveActivity()
} contentStates: {
    SurelineQuoteWidgetAttributes.ContentState.smiley
    SurelineQuoteWidgetAttributes.ContentState.starEyes
}
