//
//  quoteLockWidgetLiveActivity.swift
//  quoteLockWidget
//
//  Created by Abdul Muiz on 23/05/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct quoteLockWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct quoteLockWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: quoteLockWidgetAttributes.self) { context in
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

extension quoteLockWidgetAttributes {
    fileprivate static var preview: quoteLockWidgetAttributes {
        quoteLockWidgetAttributes(name: "World")
    }
}

extension quoteLockWidgetAttributes.ContentState {
    fileprivate static var smiley: quoteLockWidgetAttributes.ContentState {
        quoteLockWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: quoteLockWidgetAttributes.ContentState {
         quoteLockWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: quoteLockWidgetAttributes.preview) {
   quoteLockWidgetLiveActivity()
} contentStates: {
    quoteLockWidgetAttributes.ContentState.smiley
    quoteLockWidgetAttributes.ContentState.starEyes
}
