//
//  ViewController.swift
//  Mailbox
//
//  Created by Sean Smith on 9/28/15.
//  Copyright © 2015 Sean Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageRowContainer: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var navImageView: UIImageView!
    @IBOutlet weak var icon_menu: UIImageView!
    @IBOutlet weak var icon_compose: UIImageView!
    @IBOutlet weak var SearchBar: UIImageView!
    @IBOutlet weak var helpBannerImageView: UIImageView!
    @IBOutlet weak var segmentedController: UISegmentedControl!

    @IBOutlet weak var leftSideIconView: UIView!
    @IBOutlet weak var rightSideIconView: UIView!
    @IBOutlet weak var messageListIcon: UIImageView!
    @IBOutlet weak var messageDeleteIcon: UIImageView!
    @IBOutlet weak var messageLaterIcon: UIImageView!
    @IBOutlet weak var messageArchiveIcon: UIImageView!
    @IBOutlet weak var rescheduleImageButton: UIButton!
    @IBOutlet weak var listImageButton: UIButton!
    
    @IBOutlet weak var doneScreen: UIImageView!
    @IBOutlet weak var rescheduleScreen: UIImageView!
    
    
    var contentViewInitialCenter: CGPoint!
    var messageImageInitialCenter: CGPoint!
    var leftSideIconInitialCenter: CGPoint!
    var rightSideIconInitialCenter: CGPoint!
    
    var stepOne: CGFloat!
    var stepTwo: CGFloat!
    var stepThree: CGFloat!
    var stepFour: CGFloat!
    var messageImageViewOffScreen: CGFloat!
    var messageIconRightOffScreen: CGFloat!
    var messageIconLeftOffScreen: CGFloat!
    var feedMoveInt: CGFloat!
    var drawerClosed: CGFloat!
    var drawerOpen: CGFloat!
    
    var leftCenterPosition: CGFloat!
    var centerCenterPosition: CGFloat!
    var rightCenterPosition: CGFloat!

    
    var gray = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1)
    var blue = UIColor(red:0.3, green:0.73, blue:0.87, alpha:1)
    var red = UIColor(red:0.92, green:0.33, blue:0.2, alpha:1)
    var green = UIColor(red:0.45, green:0.85, blue:0.38, alpha:1)
    var yellow = UIColor(red:0.98, green:0.83, blue:0.2, alpha:1)
    var brown = UIColor(red:0.85, green:0.65, blue:0.45, alpha:1)
    
    let panRec = UIPanGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 1432)

        contentViewInitialCenter = contentView.frame.origin
        messageImageInitialCenter = messageImageView.frame.origin
        leftSideIconInitialCenter = leftSideIconView.frame.origin
        rightSideIconInitialCenter = rightSideIconView.frame.origin

       
        stepOne = CGFloat(60)
        stepTwo = CGFloat(260)
        stepThree = CGFloat(-60)
        stepFour = CGFloat(-260)
        messageImageViewOffScreen = CGFloat(500)
        messageIconRightOffScreen = CGFloat(340)
        messageIconLeftOffScreen = CGFloat(-30)
        feedMoveInt = CGFloat(144)
        drawerClosed = CGFloat(160)
        drawerOpen = CGFloat(445)
        leftCenterPosition = CGFloat(-160)
        centerCenterPosition = CGFloat(160)
        rightCenterPosition = CGFloat(480)
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)

        
        rescheduleScreen.center.x = leftCenterPosition
        scrollView.center.x = centerCenterPosition
        doneScreen.center.x = rightCenterPosition

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onRowPan(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let messageLocation = messageImageInitialCenter.x + translation.x
      
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
                        self.messageImageView.center.x = self.messageImageViewOffScreen
                        self.leftSideIconView.center.x = self.messageIconRightOffScreen
                        self.rightSideIconView.center.x = self.messageIconRightOffScreen
                        self.FeedAnimatePosition()
                    })
                } else if translation.x > self.stepOne {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = self.messageImageViewOffScreen
                        self.leftSideIconView.center.x = self.messageIconRightOffScreen
                        self.rightSideIconView.center.x = self.messageIconRightOffScreen
                        self.FeedAnimatePosition()
                    })
                } else if translation.x < self.stepFour {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = -self.messageImageViewOffScreen
                        self.leftSideIconView.center.x = self.messageIconLeftOffScreen
                        self.rightSideIconView.center.x = self.messageIconLeftOffScreen
                        self.listImageButton.alpha = 1
                    })
                } else if translation.x < self.stepThree {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = -self.messageImageViewOffScreen
                        self.leftSideIconView.center.x = self.messageIconLeftOffScreen
                        self.rightSideIconView.center.x = self.messageIconLeftOffScreen
                        self.rescheduleImageButton.alpha = 1
                    })
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.center.x = self.messageImageInitialCenter.x
                        self.leftSideIconView.center.x = self.leftSideIconInitialCenter.x
                        self.rightSideIconView.center.x = self.rightSideIconInitialCenter.x
                        self.TransparentIcons()
                    })
                }

            
        }
        
    }
    func FeedAnimatePosition(){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.rescheduleImageButton.alpha = 0
            self.listImageButton.alpha = 0
            UIView.animateWithDuration(0.3, delay: 0.3, options: [], animations: { () -> Void in
                self.feedImageView.frame.origin.y = self.feedMoveInt
                }, completion: nil)
        }
    }
    func TransparentIcons(){
        self.messageArchiveIcon.alpha = 0
        self.messageDeleteIcon.alpha = 0
        self.messageLaterIcon.alpha = 0
        self.messageListIcon.alpha = 0
    }
    
    @IBAction func RescheduleImageButton(sender: AnyObject) {
        FeedAnimatePosition()
    }
    @IBAction func ListImageButton(sender: AnyObject) {
        FeedAnimatePosition()


    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            if self.messageImageView.center.x != self.messageImageInitialCenter.x {
                self.messageRowContainer.backgroundColor = self.gray
                self.messageImageView.center.x = self.messageImageInitialCenter.x
                self.leftSideIconView.center.x = self.leftSideIconInitialCenter.x
                self.rightSideIconView.center.x = self.rightSideIconInitialCenter.x
                self.messageImageView.alpha = 0
                self.TransparentIcons()
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageImageView.alpha = 1
                    self.feedImageView.frame.origin.y = self.feedImageView.frame.origin.y + CGFloat(86)
                })
            }
        }
    }

    func onEdgePan(edgeGesture: UIScreenEdgePanGestureRecognizer){
        let edgeTranslation = edgeGesture.translationInView(view)
        let edgeVelocity = edgeGesture.velocityInView(view)
        
        if edgeGesture.state == UIGestureRecognizerState.Began{
//            NSLog("Edge Pan Began")
            contentViewInitialCenter = contentView.center

        } else if edgeGesture.state == UIGestureRecognizerState.Changed{
            
            contentView.center = CGPoint(x: drawerClosed + edgeTranslation.x, y: contentViewInitialCenter.y)
            
        } else if edgeGesture.state == UIGestureRecognizerState.Ended{
            if edgeVelocity.x > 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center = CGPoint(x: self.drawerOpen, y: self.contentViewInitialCenter.y)
                })
                        panRec.addTarget(self, action: "draggedView:")
                        contentView.addGestureRecognizer(panRec)
                        contentView.userInteractionEnabled = true

//                NSLog("Edge Pan Ended Open")
            } else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center = CGPoint(x: self.drawerClosed, y: self.contentViewInitialCenter.y)
                })
//            NSLog("Edge Pan Ended Closed")
                
            }
            
        }
        
    }
    func draggedView(sender:UIPanGestureRecognizer){
        let panTranslation = panRec.translationInView(view)
        let panVelocity = panRec.velocityInView(view)
//        let contentViewLocation = contentViewInitialCenter.x + panTranslation.x
        //        NSLog("Pan in a Pan")
        
        if sender.state == UIGestureRecognizerState.Began {
//            NSLog("Menu Pan Began \(contentViewLocation)")
            contentViewInitialCenter = contentView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            contentView.center = CGPoint(x: contentViewInitialCenter.x + panTranslation.x, y: contentViewInitialCenter.y)

            
//            NSLog("Menu Pan Changed \(contentViewLocation)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            if panVelocity.x > 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center.x = CGFloat(self.drawerOpen)
                })
            } else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.contentView.center.x = CGFloat(self.drawerClosed)
                })
//                NSLog("Menu Pan Ended \(contentViewLocation)")

            }
        }
    }

    
    @IBAction func onSegmentedControllerChange(sender: UISegmentedControl) {
        icon_compose.image = icon_compose.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        icon_menu.image = icon_menu.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)

        if segmentedController.selectedSegmentIndex == 0{
            rescheduleScreen.alpha = 1
            segmentedController.tintColor = self.yellow
            icon_menu.tintColor = self.yellow
            icon_compose.tintColor = self.yellow
            UIView.animateWithDuration(0.2, delay: 0.1, options: [], animations: { () -> Void in
                self.rescheduleScreen.center.x = self.centerCenterPosition
                self.scrollView.center.x = self.rightCenterPosition
                self.doneScreen.center.x = self.rightCenterPosition
                }, completion: nil)
            
        } else if segmentedController.selectedSegmentIndex == 2 {
            doneScreen.alpha = 1
            segmentedController.tintColor = self.green
            icon_menu.tintColor = self.green
            icon_compose.tintColor = self.green
            UIView.animateWithDuration(0.2, delay: 0.1, options: [], animations: { () -> Void in
                self.rescheduleScreen.center.x = self.leftCenterPosition
                self.scrollView.center.x = self.leftCenterPosition
                self.doneScreen.center.x = self.centerCenterPosition
                }, completion: nil)
            
        } else {
            segmentedController.tintColor = self.blue
            icon_menu.tintColor = self.blue
            icon_compose.tintColor = self.blue
            UIView.animateWithDuration(0.2, delay: 0.1, options: [], animations: { () -> Void in
                self.rescheduleScreen.center.x = self.leftCenterPosition
                self.scrollView.center.x = self.centerCenterPosition
                self.doneScreen.center.x = self.rightCenterPosition
                }, completion: nil)
        }
    }
}


