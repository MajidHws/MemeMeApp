//
//  ViewController.swift
//  MemeMeApp
//
//  Created by MajidHws on 10/21/18.
//  Copyright © 2018 MajidHws. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    
    
    
    
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var imgPickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    var screenSize = 0
    
//    struct Meme {
//        var topText: String
//        var casebottomText:String
//        var originalImage: UIImage
//        var memedImage: UIImage
//    }
    
    
    let memeTextAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.blue/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4.0 /* TODO: fill in appropriate Float */]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField(tf: topTextField, text: "TOP")
        setupTextField(tf: bottomTextField, text: "BOTTOM")
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        shareButton.isEnabled = false
        
        screenSize = Int(view.frame.origin.y)
        
        
        
    }
    
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black/* TODO: fill in appropriate UIColor */,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.blue/* TODO: fill in appropriate UIColor */,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4.0 /* TODO: fill in appropriate Float */
        ]
        
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subcribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imageSource(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickImage(_ sender: Any) {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.sourceType = .photoLibrary
//        present(pickerController, animated: true, completion: nil)
        
        imageSource(source: .photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage {
            imgPickerView.image = image
        }
        
        shareButton.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.sourceType = .camera
//        present(pickerController, animated: true, completion: nil)
            imageSource(source: .camera)
    }
    
    func textFieldDidBeginEditing(_ tx: UITextField){
        tx.text = ""
    }
    
    func textFieldShouldReturn(_ tx: UITextField) -> Bool {
        tx.resignFirstResponder()
        unsubscribeFromKeyboardNotifications()
        return true

    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getkeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        view.frame.origin.y = CGFloat(screenSize)
//        view.frame.origin.y = view.frame.origin.y + getkeyboardHeight(notification)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        print("hide.")
    }
    
    func subcribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        print("keyboard up!")
    }
    
    func getkeyboardHeight(_ notification: Notification) -> CGFloat {
    
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications() {
        //NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        view.frame.origin.y = CGFloat(screenSize)
        view.frame.origin.y = 0
        print("unsubscribe")
    }
    
    func save() {
        // Create the meme
        let memedImage = generateMemedImage()
        //imgPickerView.image = memedImage
        let meme = Meme(topText: topTextField.text!, casebottomText: bottomTextField.text!, originalImage: imgPickerView.image!, memedImage: memedImage)
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.memes.append(meme)
        
        let obj = UIApplication.shared.delegate
        let appd = obj as! AppDelegate
        appd.memes.append(meme)
        print("\nsaved!\n \(appd.memes)")
    }
    
    func generateMemedImage() -> UIImage {
        
//        toolBar.isHidden = true
//        shareButton.isHidden = true
        enableBtn(status: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.dismiss(animated: true, completion: nil)
//                self.toolBar.isHidden = false
//                self.shareButton.isHidden = false
                self.enableBtn(status: false)
                
            }
        }
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
//        toolBar.isHidden = false
//        shareButton.isHidden = false
        enableBtn(status: false)
    }
    
    func enableBtn(status: Bool) {
        toolBar.isHidden = status
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

