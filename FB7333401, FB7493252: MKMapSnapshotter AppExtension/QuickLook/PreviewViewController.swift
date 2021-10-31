//
//  PreviewViewController.swift
//  QuickLook
//
//  Created by Arthur on 29/09/2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit
import MapKit
import QuickLook

class PreviewViewController: UIViewController, QLPreviewingController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        let options = MKMapSnapshotter.Options()

        do {
            let point = try Point.content(of: url)
            options.region = point.region()
        } catch {
            handler(error)
            return
        }
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { (snapshot, error) in
            self.imageView.image = snapshot?.image
            self.label.text = error?.localizedDescription ?? "MKMapSnapshotter runs without an error, you should see a map"
//            handler(error)
            handler(nil)
        }

    }

}
