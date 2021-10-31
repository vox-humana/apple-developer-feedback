//
//  ViewController.swift
//  MKMapSnapshotterDemo
//
//  Created by Arthur on 29/09/2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit
import MapKit
import QuickLook

class ViewController: UIViewController, QLPreviewControllerDataSource {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let point = try? Point.content(of: fileURL) else {
            return
        }

        let options = MKMapSnapshotter.Options()
        options.region = point.region()

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { (snapshot, error) in
            self.imageView.image = snapshot?.image
        }
    }
    
    @IBAction func showPreview(_ sender: Any) {
        let preview = QLPreviewController()
        preview.dataSource = self
        present(preview, animated: true, completion: nil)
    }
    
    @IBAction func showThumbnail(_ sender: UIBarButtonItem) {
        let share = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        share.popoverPresentationController?.barButtonItem = sender
        present(share, animated: true, completion: nil)        
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURL as QLPreviewItem
    }
    
    private var fileURL: URL {
        return Bundle.main.url(forResource: "test-file", withExtension: "mksnapshotter")!
    }
}

