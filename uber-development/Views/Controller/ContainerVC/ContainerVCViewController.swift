//
//  ContainerVCViewController.swift
//  uber-development
//
//  Created by Nathan on 20/06/2019.
//  Copyright © 2019 Nathan. All rights reserved.
//

import UIKit
import QuartzCore

enum slideOutState{
    case collapsed
    case leftPanelExpanded
}
enum showVC{
    case homeVC
}
var showvc: showVC = .homeVC
class ContainerVCViewController: UIViewController {

    var homeVC: PassengerHomeViewController!
    var leftvc: LeftSidePanelVC!
    var currentState: slideOutState = .collapsed{
        didSet{
             let shouldShowShadow = (currentState != .collapsed)
             shouldShowShadowForCenterVC(shouldShowShadow)
        }
    }
    var isHidden = false
    var centerController: UIViewController!
    var tapped: UITapGestureRecognizer!
    let centerPanelExpandedOffset: CGFloat = 200
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showvc)
    }
    
    func initCenter(screen: showVC){
        var presentingVC: UIViewController
        showvc = screen
        if homeVC == nil{
            homeVC = UIStoryboard.passengerHomeVC()
            homeVC.delegate = self
        }
        presentingVC = homeVC
        if let con = centerController{
            con.view.removeFromSuperview()
            con.removeFromParent()
        }
        centerController = presentingVC
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
        override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
            return UIStatusBarAnimation.slide
        }
        override var prefersStatusBarHidden: Bool{
            return isHidden
        }
}
extension ContainerVCViewController: centerVCDelegate{
    func toggleLeftPanel() {
        let notExpanded =  (self.currentState != .leftPanelExpanded)
        if notExpanded{
            addLeftPanelVC()
        }
        animateLeftPanel(shouldExpand: notExpanded)
    }
    
    func addLeftPanelVC() {
        if self.leftvc == nil{
            self.leftvc = UIStoryboard.leftVC()
            addChildSidePanelVC(self.leftvc)
        }
    }
    
    
    func addChildSidePanelVC(_ sidePanelController: LeftSidePanelVC){
        view.insertSubview(sidePanelController.view, at: 0)
        self.addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand{
            self.isHidden = !self.isHidden
            animateStatusBar()
            setupWhiteCoverView()
            self.currentState = .leftPanelExpanded
            animateCenterPanelXPosition(targetPosition: self.centerController.view.frame.width - self.centerPanelExpandedOffset)
        }else{
            self.isHidden = !self.isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                if finished{
                    self.currentState = .collapsed
                    self.leftvc = nil
                }
            })
        }
    }
    
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    func setupWhiteCoverView(){
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = .white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        
        self.tapped = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand: )))
        self.tapped.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tapped)
    }
    func hideWhiteCoverView(){
        centerController.view.removeGestureRecognizer(tapped)
        for subview in self.centerController.view.subviews{
            if subview.tag == 25{
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }) { (finished) in
                    if finished{
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    func shouldShowShadowForCenterVC(_ status: Bool){
        if status{
            self.centerController.view.layer.shadowOpacity = 0.6
        }else{
            self.centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    
}

private extension UIStoryboard{
    class func mainSB() -> UIStoryboard{
        
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftVC() -> LeftSidePanelVC?{
        return mainSB().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    class func passengerHomeVC() -> PassengerHomeViewController?{
        return mainSB().instantiateViewController(withIdentifier: "PassengerHomeViewController") as? PassengerHomeViewController
    }
}
