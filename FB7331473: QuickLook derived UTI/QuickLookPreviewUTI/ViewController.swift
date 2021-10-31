//
//  ViewController.swift
//  QuickLookPreviewUTI
//
//  Created by Arthur Semenyutin on 28/9/19.
//  Copyright © 2019 Arthur Semenyutin. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController, QLPreviewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openPreview(_ sender: Any) {
        let previewVC = QLPreviewController()
        previewVC.dataSource = self
        present(previewVC, animated: true, completion: nil)
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        let fileURL = Bundle.main.url(forResource: "wiki", withExtension: "gpx")!
        return fileURL as QLPreviewItem
    }
}

