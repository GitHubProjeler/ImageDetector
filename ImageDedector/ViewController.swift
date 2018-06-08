//
//  ViewController.swift
//  ImageDedector
//
//  Created by fatih on 8.06.2018.
//  Copyright © 2018 fatih. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func detectImage(){
        resultLabel.text = "Resim tanımlamasıyapılıyor..."
    }
    @IBAction func chooseImage(_ sender: Any) {
    }
    
}

