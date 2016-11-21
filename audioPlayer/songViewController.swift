//
//  songViewController.swift
//  audioPlayer
//
//  Created by Keertika Gupta on 29/10/16.
//  Copyright © 2016 Keertika Gupta. All rights reserved.
//

import UIKit
import AVFoundation
class songViewController: UIViewController
{
    var player: AVAudioPlayer {
        get {
            let application = UIApplication.sharedApplication().delegate as! AppDelegate
            return application.player
        }
        set {
            let application = UIApplication.sharedApplication().delegate as! AppDelegate
            //            application.player.stop()
        application.player = newValue
        }
    }
    //var selectedSong: String?
    var nameOfSelectedSong: String?
    var nameOfSelectedImage: String?
    
    
    
    @IBAction func playbutton(sender: UIBarButtonItem) {
        player.play()
    }
   
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
   
    @IBOutlet weak var slider: UISlider!
    @IBAction func refreshButton(sender: UIBarButtonItem) {
        player.stop()
        player.currentTime = 0
        player.play()
    }
    
    
    @IBAction func pausebutton(sender: UIBarButtonItem) {
        player.pause()
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        playSong()
        print (nameOfSelectedSong)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        //UIViewContentMode.ScaleAspectFill
        self.imageView.image = UIImage(named: nameOfSelectedSong!)
        slider.maximumValue = Float(player.duration)
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(songViewController.updateSlider), userInfo: nil, repeats: true)
        
        
    }
    
    func playSong()
    {
        let audioPath = NSBundle.mainBundle().pathForResource( nameOfSelectedSong , ofType: "mp3")
        
        if let audioPath = audioPath
        {
            let pathURL = NSURL(fileURLWithPath: audioPath)
            
            do
            {
                try player = AVAudioPlayer(contentsOfURL: pathURL )
                player.play()
                //[contentsOf: NSURL(fileURLWithPath: audioPath)]
            }
            catch
            {
                
                print("error")
                
            }
            
        }
        
    }
    
    
    @IBAction func sliderProgress(sender: AnyObject) {
        
        player.stop()
        player.currentTime = NSTimeInterval(slider.value)
        player.prepareToPlay()
        player.play()
    }
    /*  func fetchImage()
     { imageView.image = UIImage(named: "ADHM.jpg")
     }
     */
    func updateSlider()
    {
        slider.value = Float(player.currentTime)
    }
    
}
