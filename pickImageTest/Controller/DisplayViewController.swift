//
//  DisplayViewController.swift
//  pickImageTest
//
//  Created by iMac on 22/03/22.
//

import UIKit

class DisplayViewController: UIViewController,UIGestureRecognizerDelegate {
    
    //MARK:- IBOutlet
    @IBOutlet weak var lblDisplayImoji: UILabel!
    @IBOutlet var vwCollection: UICollectionView!
    @IBOutlet var imgDisplay: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK:- Variable
    var image: UIImage = UIImage()
    let Imogies = ["😍","😁","😅","😇","🤓","😛","🥸","🥰","😰"]
    var pinchGesture = UIPinchGestureRecognizer()
     
    
    //MARK:- Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
}


//MARK:- IBAction
extension DisplayViewController {
    
    // Dismiss button
    @IBAction func btnDismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
     
    // Save button
    @IBAction func btnSaveAction(_ sender: Any) {
        
        let selectedImage =  UIImage.init(view: containerView)
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}


//MARK:- Helper Method
extension DisplayViewController {
    
    func setUpUi() {
        
        self.containerView.layer.borderWidth = 2.0
        self.lblDisplayImoji.isUserInteractionEnabled = true
        self.lblDisplayImoji.isMultipleTouchEnabled = true
            
        pinchGesture.delegate = self
        self.pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(pinchRecognized(_:)))
        self.lblDisplayImoji.addGestureRecognizer(self.pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        lblDisplayImoji.addGestureRecognizer(panGesture)
        
        imgDisplay.image = image
        vwCollection.register(UINib(nibName: "cell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
    }
    
    //Drag imoji
    @objc func draggedView(_ sender:UIPanGestureRecognizer) {
        lblDisplayImoji.superview?.bringSubviewToFront(containerView)
        
        let translation = sender.translation(in: self.containerView)
        self.lblDisplayImoji.center = CGPoint(x: self.lblDisplayImoji.center.x + translation.x, y: self.lblDisplayImoji.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    //Increse/Decrese imoji size by PinchGesture
    @objc func pinchRecognized(_ pinch: UIPinchGestureRecognizer) {
        let fontSize = self.lblDisplayImoji.font!.pointSize*(pinch.scale)/2
        if fontSize > 20 && fontSize < 80{
            lblDisplayImoji.font = UIFont(name: self.lblDisplayImoji.font!.fontName, size:fontSize)
        }
    }
     
    
    //Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.showAlert(error.localizedDescription)
        } else {
            self.showAlert("Your image has been saved to your photos.")
        }
    } 
}


//MARK:- CollectionViewController Delegate
extension DisplayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Imogies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
        cell.imojiLabel.text = Imogies[indexPath.row]
        //cell.imojiLabel.text = " \(self.Imogies[indexPath.row]) "
               return cell
         
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lblDisplayImoji.text = Imogies[indexPath.row]
    }
}



