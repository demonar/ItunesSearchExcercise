//
//  BaseViewController.swift
//
//
//  Created by DeMoN on 9/9/15.
//  
//

import UIKit
import enum Result.NoError

public typealias NoError = Result.NoError


class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var statusBarStyle: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAppearance()
        self.configureControls()
        self.configureData()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func configureAppearance() {
        
    }
    
    func configureControls() {
        
    }
    
    func configureData() {
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return self.statusBarStyle
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
    }
    
    override var shouldAutorotate : Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? false : true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
