//
//  ViewController.swift
//  audioPlayer
//
//  Created by Keertika Gupta on 28/10/16.
//  Copyright © 2016 Keertika Gupta. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController ,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate , UITableViewDelegate , UITableViewDataSource
{
    let customNavigationAnimationController = songViewController()
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
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.whiteColor()//blueColor()
            cell.selectedBackgroundView = backgroundView

      
return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let VC = self.storyboard?.instantiateViewControllerWithIdentifier("songViewController") as! songViewController
                VC.nameOfSelectedSong = songs[indexPath.row]
        VC.nameOfSelectedImage = images[indexPath.row]
 
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
        navigationController?.delegate = self
        super.viewDidLoad()
      
            }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        customNavigationAnimationController.reverse = operation == .Pop
        return customNavigationAnimationController
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return .Bottom
    }

}
