import AVFoundation
import CoreImage.CIFilterBuiltins
import UIKit
import SwiftUI
import AVKit

class VideoRenderer {
    func makeVideoPlayerItem(videoURL: String, textImageURL: String, completion: @escaping (URL?, Double) -> Void) {
        print("am there")
        
        // Guard against invalid URL
        guard let url = URL(string: videoURL) else {
            print("Invalid video URL: \(videoURL)")
            completion(nil, 0)
            return
        }
        
        guard let urlText = URL(string: textImageURL) else {
            print("Invalid text URL: \(textImageURL)")
            completion(nil, 0)
            return
        }
        
        print("url done")
        
        let asset = AVAsset(url: url)
        print("asset done")
        
        // Check if asset contains video tracks
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            print("No video track found in asset")
            completion(nil, 0)
            return
        }
        
        let composition = AVMutableVideoComposition(asset: asset) { request in
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 5
            shadow.shadowColor = UIColor.white
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont(name: "Marker Felt", size: 36.0)!,
//                .shadow: shadow
            ]
            
//            let attributedText = NSAttributedString(string: text, attributes: attributes)
//            let textFilter = CIFilter.attributedTextImageGenerator()
//            textFilter.text = attributedText
//            textFilter.scaleFactor = 1.0
            
//            let outputImage = textFilter.outputImage!
            guard let outputImage = CIImage(contentsOf: urlText) else {
                print("Invalid text Image")
                return
            }
            
            print("image size")
            print(outputImage.extent.width)
            print(outputImage.extent.height)
            
//            let centerX = (request.renderSize.width - outputImage.extent.width) / 2
//            let centerY = (request.renderSize.height - outputImage.extent.height) / 2
//            let transform = CGAffineTransform(translationX: centerX, y: centerY)
//            let finalTextImage = outputImage.transformed(by: transform)
            
            let imageWidth = outputImage.extent.width
            let imageHeight = outputImage.extent.height

            let maxWidth = request.renderSize.width
            let maxHeight = request.renderSize.height

            let scale = min(maxWidth / imageWidth, maxHeight / imageHeight, 1.0) // Scale down only if needed

            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))

            let newWidth = scaledImage.extent.width
            let newHeight = scaledImage.extent.height

            let centerX = (maxWidth - newWidth) / 2
            let centerY = (maxHeight - newHeight) / 2

            let finalTextImage = scaledImage.transformed(by: CGAffineTransform(translationX: centerX, y: centerY))

            
            let result = finalTextImage.composited(over: request.sourceImage)
            request.finish(with: result, context: nil)
        }
        
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.videoComposition = composition
        
        let fakeSize = videoTrack.naturalSize
        let size = CGSize(width: fakeSize.height, height: fakeSize.width)
        print(size.width)
        print(size.height)
         
        composition.renderSize = fakeSize
        composition.frameDuration = CMTimeMake(value: 1, timescale: 30)

        // Export path
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("ExportedVideo.mov")

        // Remove existing file if needed
        do {
            try FileManager.default.removeItem(at: outputURL)
        } catch {
            print("Error removing existing file at output URL: \(error.localizedDescription)")
        }

        // Export session
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
            print("Cannot create export session")
            completion(nil, 0)
            return
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mov
        exportSession.videoComposition = composition

        // Start observing progress
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [exportSession] timer in
            print("Progress: \(exportSession.progress * 100)%")
            
            DispatchQueue.main.async {
                if exportSession.status == .completed {
                    print("Export succeeded: \(outputURL)")
                    completion(outputURL, 1.0)
                    timer.invalidate()
                } else if exportSession.status == .failed || exportSession.status == .cancelled {
                    print("Export failed: \(exportSession.error?.localizedDescription ?? "unknown error")")
                    completion(nil, 0)
                    timer.invalidate()
                } else {
                    // Update progress as export continues
                    completion(nil, Double(exportSession.progress))
                }
            }
        }

        // Handle asynchronous export
        exportSession.exportAsynchronously {
            if exportSession.status == .failed || exportSession.status == .cancelled {
                print("Export finished with error: \(exportSession.error?.localizedDescription ?? "unknown error")")
                completion(nil, 0)
            }
        }
    }
}
