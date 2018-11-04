//
//  ViewerViewController.swift
//  MemeMeApp
//
//  Created by MajidHws on 11/2/18.
//  Copyright © 2018 MajidHws. All rights reserved.
//

import UIKit

class ViewerViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var memeIndex = 0;
    
    var memes: [Meme]! {
        let obj = UIApplication.shared.delegate
        let appd = obj as! AppDelegate
        return appd.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
        // Do any additional setup after loading the view.
    }
    
    func setUpImage() {
        self.img.image = self.memes[memeIndex].memedImage
        print(memeIndex)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
