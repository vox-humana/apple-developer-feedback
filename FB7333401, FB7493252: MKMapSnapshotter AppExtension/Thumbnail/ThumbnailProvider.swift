//
//  ThumbnailProvider.swift
//  Thumbnail
//
//  Created by Arthur on 29/09/2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit
import MapKit
import QuickLookThumbnailing

class ThumbnailProvider: QLThumbnailProvider {
    
    override func provideThumbnail(for request: QLFileThumbnailRequest, _ handler: @escaping (QLThumbnailReply?, Error?) -> Void) {
        
        // There are three ways to provide a thumbnail through a QLThumbnailReply. Only one of them should be used.
        
        // First way: Draw the thumbnail into the current context, set up with UIKit's coordinate system.
        handler(QLThumbnailReply(contextSize: request.maximumSize, currentContextDrawing: { () -> Bool in

            let options = MKMapSnapshotter.Options()
            do {
                let point = try Point.content(of: request.fileURL)
                options.region = point.region()
            } catch {
                return false
            }

            var result = false
            let semaphore = DispatchSemaphore(value: 0)
            let snapshotter = MKMapSnapshotter(options: options)
            snapshotter.start { (snapshot, error) in
                snapshot?.image.draw(at: .zero)
                result = error == nil
                semaphore.signal()
            }

            semaphore.wait()
            return result
        }), nil)
        
        /*
        
        // Second way: Draw the thumbnail into a context passed to your block, set up with Core Graphics's coordinate system.
        handler(QLThumbnailReply(contextSize: request.maximumSize, drawing: { (context) -> Bool in
            // Draw the thumbnail here.
         
            // Return true if the thumbnail was successfully drawn inside this block.
            return true
        }), nil)
         
        // Third way: Set an image file URL.
        handler(QLThumbnailReply(imageFileURL: Bundle.main.url(forResource: "fileThumbnail", withExtension: "jpg")!), nil)
        
        */
    }
}
