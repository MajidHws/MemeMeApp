//
//  TableCollectionViewController.swift
//  MemeMeApp
//
//  Created by MajidHws on 10/31/18.
//  Copyright © 2018 MajidHws. All rights reserved.
//

import UIKit

class TableCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]! {
        let obj = UIApplication.shared.delegate
        let appd = obj as! AppDelegate
        return appd.memes
    }
    
    var list = ["1", "2", "3", "4"]
    
    let appDelegate = AppDelegate()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell") as! ItemTableViewCell
        
        cell.title?.text = memes[indexPath.row].topText
        cell.desc?.text = memes[indexPath.row].casebottomText
        cell.img.image = memes[indexPath.row].memedImage
        
//        cell.title?.text = list[indexPath.row]
//        cell.desc?.text = list[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewImg", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewImg" {
            let controller = segue.destination as! ViewerViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                controller.memeIndex = selectedRow
//                controller.img.image = self.memes[selectedRow].memedImage!
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
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
