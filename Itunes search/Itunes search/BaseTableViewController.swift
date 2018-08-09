//
//  BaseTableViewController.swift
//
//
//  Created by DeMoN on 9/15/15.
//  
//

import UIKit


class BaseTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    var statusBarStyle: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.configureAppearance()
        self.configureControls()
        self.configureData()
    }

    func configureControls() {
        self.refreshControl = Utilities.createRefreshControl(target: self, selector: #selector(refresh(_:)))
    }
    
    func configureData() {
    }
    
    func configureAppearance() {
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl?) {
        Utilities.delay(0.5) {
            refreshControl?.endRefreshing()
        }
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
