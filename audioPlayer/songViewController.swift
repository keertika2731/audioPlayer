//
//  songViewController.swift
//  audioPlayer
//
//  Created by Keertika Gupta on 29/10/16.
//  Copyright © 2016 Keertika Gupta. All rights reserved.
//

import UIKit
import AVFoundation
class songViewController: UIViewController, UIViewControllerAnimatedTransitioning
{var reverse: Bool = false
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
        //super.viewDidLoad()
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
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView = toViewController.view
        let fromView = fromViewController.view
        let direction: CGFloat = reverse ? -1 : 1
        let const: CGFloat = -0.005
        
        toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5)
        fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5)
        
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        containerView.transform = CGAffineTransformMakeTranslation(direction * containerView.frame.size.width / 2.0, 0)
        toView.layer.transform = viewToTransform
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            containerView.transform = CGAffineTransformMakeTranslation(-direction * containerView.frame.size.width / 2.0, 0)
            fromView.layer.transform = viewFromTransform
            toView.layer.transform = CATransform3DIdentity
            }, completion: {
                finished in
                containerView.transform = CGAffineTransformIdentity
                fromView.layer.transform = CATransform3DIdentity
                toView.layer.transform = CATransform3DIdentity
                fromView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                toView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                
                if (transitionContext.transitionWasCancelled()) {
                    toView.removeFromSuperview()
                } else {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
}
