//
//  SceneDelegate.swift
//  pickImageTest
//
//  Created by iMac on 22/03/22.
//

import UIKit

//Image extension
extension UIImage {
    
    //Convert view into image
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}


//UIViewController extension
extension UIViewController {
    //Show alert
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
