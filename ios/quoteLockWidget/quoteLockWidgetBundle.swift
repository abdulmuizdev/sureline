//
//  quoteLockWidgetBundle.swift
//  quoteLockWidget
//
//  Created by Abdul Muiz on 23/05/2025.
//

import WidgetKit
import SwiftUI

@main
struct quoteLockWidgetBundle: WidgetBundle {
    var body: some Widget {
        SurelineQuoteLockWidget()
        quoteLockWidgetControl()
        quoteLockWidgetLiveActivity()
    }
}
