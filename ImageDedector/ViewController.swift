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
        detectImage()
    }

    func detectImage(){
        resultLabel.text = "Resim tanımlaması yapılıyor..."
        guard let model = try? VNCoreMLModel(for:GoogLeNetPlaces().model) else {
            fatalError("Model Dosyası Bulunamadı / Yüklenemedi...")
        }
        
        //vision request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation],
                let firstResult = results.first else {
                    fatalError("Beklenmeyen Hata Oluştu")
            }
            print("****Tüm tahminler \(results)")
            //label a yazdırma
            DispatchQueue.main.async {
                self.resultLabel.text = "\(firstResult.identifier)"
            }
        }
        
        guard let ciImage = CIImage(image:self.myPhoto.image!) else{
            fatalError("Resim dönüşümünde hata meydana geldi")
        }
        
        //Model dosyasının çalıştırılması için son adım
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do{
                try handler.perform([request])
            }catch{
                print("Bir hata meydana geldi.")
            }
        }
    }
    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        //resim seçme ekranının açılması
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else{
            return
        }
        myPhoto.image = image
        self.dismiss(animated: true, completion: nil)
        detectImage()
    }
}




