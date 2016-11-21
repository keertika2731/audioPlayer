//
//  ViewController.swift
//  audioPlayer
//
//  Created by Keertika Gupta on 28/10/16.
//  Copyright © 2016 Keertika Gupta. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource
{
    var songs = ["ADHM", "Besabriyaan"]
    var images = ["ADHM", "Besabriyaan"]
    @IBOutlet weak var table: UITableView!
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int
    {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = songs[indexPath.row]
return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("songViewController") as! songViewController
        VC.title = songs[indexPath.row]
        VC.nameOfSelectedSong = songs[indexPath.row]
        VC.nameOfSelectedImage = images[indexPath.row]
 //let lenght = self.viewControllers.count
     //if condition nh chal rai
        if (self.navigationController?.topViewController!.isEqual(songViewController) != nil)
        {            print("already")
            showViewController(VC, sender: nil)
        }
            else
            { print("not")
            }
    }
  // let doesContain = [self.view.subviewscontainsObject:pageShadowView];
   
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
    }
    
  
}
