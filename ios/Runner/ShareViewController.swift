/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FacebookShare
import UIKit

final class ShareViewController: UITableViewController {

    func shareLink() {
        print("called")
        guard let url = URL(string: "https://newsroom.fb.com/") else {
            preconditionFailure("URL is invalid")
        }

        let content = ShareLinkContent()
        content.contentURL = url
        content.hashtag = Hashtag("#bestSharingSampleEver")

        dialog(withContent: content).show()
        print("finished")
    }

    func dialog(withContent content: SharingContent) -> ShareDialog {
        print("calling dialog")
        return ShareDialog(
            viewController: self,
            content: content,
            delegate: self
        )
    }
}

extension ShareViewController: SharingDelegate {

    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print(results)
    }

    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print(error)
        presentAlert(for: error)
    }

    func sharerDidCancel(_ sharer: Sharing) {
        print("cancelled")
        presentAlert(title: "Cancelled", message: "Sharing cancelled")
    }
}
