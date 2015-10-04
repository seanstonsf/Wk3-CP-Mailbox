//
//  ViewController.swift
//  Mailbox
//
//  Created by Sean Smith on 9/28/15.
//  Copyright © 2015 Sean Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageRowContainer: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var SearchBar: UIImageView!
    @IBOutlet weak var helpBannerImageView: UIImageView!

    @IBOutlet weak var leftSideIconView: UIView!
    @IBOutlet weak var rightSideIconView: UIView!
    @IBOutlet weak var messageListIcon: UIImageView!
    @IBOutlet weak var messageDeleteIcon: UIImageView!
    @IBOutlet weak var messageLaterIcon: UIImageView!
    @IBOutlet weak var messageArchiveIcon: UIImageView!
    
    var messageImageInitialCenter: CGPoint!
    var leftSideIconInitialCenter: CGPoint!
    var rightSideIconInitialCenter: CGPoint!
    
    var stepOne: CGFloat!
    var stepTwo: CGFloat!
    var stepThree: CGFloat!
    var stepFour: CGFloat!
    
    var gray = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1)
    var red = UIColor(red:0.92, green:0.33, blue:0.2, alpha:1)
    var green = UIColor(red:0.45, green:0.85, blue:0.38, alpha:1)
    var yellow = UIColor(red:0.98, green:0.83, blue:0.2, alpha:1)
    var brown = UIColor(red:0.85, green:0.65, blue:0.45, alpha:1)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1432)

        messageImageInitialCenter = messageImageView.frame.origin
        leftSideIconInitialCenter = leftSideIconView.frame.origin
        rightSideIconInitialCenter = rightSideIconView.frame.origin
        
        stepOne = CGFloat(60)
        stepTwo = CGFloat(260)
        stepThree = CGFloat(-60)
        stepFour = CGFloat(-260)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onRowPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let messageLocation = messageImageInitialCenter.x + translation.x

//        let swipeStepOne = messageLocation + stepOne
//        let swipeStepThree = messageLocation + stepThree
        
        if sender.state == UIGestureRecognizerState.Began {
            NSLog("began panning at \(location)")
            messageImageInitialCenter = messageImageView.center
            leftSideIconInitialCenter = leftSideIconView.center
            rightSideIconInitialCenter = rightSideIconView.center
            UIView.animateWithDuration(0.2, delay: 0.2, options: [], animations: { () -> Void in
                self.messageArchiveIcon.alpha = 1
                self.messageDeleteIcon.alpha = 0
                self.messageLaterIcon.alpha = 1
                self.messageListIcon.alpha = 0

                }, completion: nil)
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageImageView.center = (CGPoint(x: messageImageInitialCenter.x + translation.x, y: messageImageInitialCenter.y))
            rightSideIconView.center = (CGPoint(x: rightSideIconInitialCenter.x + translation.x, y: rightSideIconInitialCenter.y))
            leftSideIconView.center = (CGPoint(x: leftSideIconInitialCenter.x + translation.x, y: leftSideIconInitialCenter.y))

            if translation.x > stepTwo {
                print("step 2 \(messageLocation)")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageRowContainer.backgroundColor = self.red
                    self.messageArchiveIcon.alpha = 0
                    self.messageDeleteIcon.alpha = 1
                })
                
            } else if translation.x > stepOne {
                print("step 1 \(messageLocation)")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageRowContainer.backgroundColor = self.green
                    self.messageArchiveIcon.alpha = 1
                    self.messageDeleteIcon.alpha = 0
                })
               
            } else if translation.x < stepFour {
                print("step 4 \(messageLocation)")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageRowContainer.backgroundColor = self.brown
                    self.messageLaterIcon.alpha = 0
                    self.messageListIcon.alpha = 1
                })
           
            } else if translation.x < stepThree {
                print("step 3 \(messageLocation)")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageRowContainer.backgroundColor = self.yellow
                    self.messageLaterIcon.alpha = 1
                    self.messageListIcon.alpha = 0
                })
                
            } else {
                print("nope \(messageLocation)")
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageRowContainer.backgroundColor = self.gray
                })
            }

           
        } else if sender.state == UIGestureRecognizerState.Ended {

                if translation.x > self.stepTwo {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = 500
                        self.leftSideIconView.center.x = 360
                        self.rightSideIconView.center.x = 360
                    })
                } else if translation.x > self.stepOne {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = 500
                        self.leftSideIconView.center.x = 360
                        self.rightSideIconView.center.x = 360
                    })
                } else if translation.x < self.stepFour {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = -500
                        self.leftSideIconView.center.x = -60
                        self.rightSideIconView.center.x = -60
                    })
                } else if translation.x < self.stepThree {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = -500
                        self.leftSideIconView.center.x = -60
                        self.rightSideIconView.center.x = -60

                    })
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = self.messageImageInitialCenter.x
                        self.leftSideIconView.center.x = self.leftSideIconInitialCenter.x
                        self.rightSideIconView.center.x = self.rightSideIconInitialCenter.x
                        self.messageArchiveIcon.alpha = 0
                        self.messageDeleteIcon.alpha = 0
                        self.messageLaterIcon.alpha = 0
                        self.messageListIcon.alpha = 0

                        
                    })
                }

            
        }
        
    }

}


