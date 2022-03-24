//
//  ViewController.swift
//  pickImageTest
//
//  Created by iMac on 22/03/22.
//

import UIKit
import MobileCoreServices

class ViewController : UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var imgVw: UIImageView!
    @IBOutlet var btnCamera: UIButton!
    
    //MARK:- Variable
    var imag = UIImagePickerController()
    
    
    //MARK:- Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK:- IBAction
extension ViewController {
    
    //Camera button
    @IBAction func btnCameraAction(_ sender: Any) {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imageController.sourceType = UIImagePickerController.SourceType.camera
        self.present(imageController,animated: true,completion: nil)
    }
    
    //Photo button
    @IBAction func btnGallery(_ sender: Any) {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imageController,animated: true,completion: nil)
    }
}


//MARK:- UIImagePickerController Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        self.dismiss(animated: true) {
            let vc = storyBoard.instantiateViewController(withIdentifier: "DisplayViewController") as! DisplayViewController
            vc.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.dismiss(animated: true, completion: nil)
        
        
    }
}



