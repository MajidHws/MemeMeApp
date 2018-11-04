//
//  CollectionViewController.swift
//  MemeMeApp
//
//  Created by MajidHws on 10/30/18.
//  Copyright © 2018 MajidHws. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var memes = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        // Do any additional setup after loading the view.
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
