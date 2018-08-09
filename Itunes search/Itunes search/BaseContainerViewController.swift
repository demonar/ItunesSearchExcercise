//
//  BaseContainerViewController.swift
//
//
//  Created by Alejandro Moya on 1/17/18.
//
//

import UIKit

class BaseContainerViewController: BaseViewController {
    
    var containerStackView = UIStackView()
    
    override func configureAppearance() {
        super.configureAppearance()
        self.containerStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.containerStackView)
        let topAnchor: NSLayoutYAxisAnchor
        let bottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11, *) {
            topAnchor = self.view.safeAreaLayoutGuide.topAnchor
            bottomAnchor = self.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            topAnchor = self.topLayoutGuide.bottomAnchor
            bottomAnchor = self.bottomLayoutGuide.topAnchor
        }
        self.view.leftAnchor.constraint(equalTo: self.containerStackView.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: self.containerStackView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: self.containerStackView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: self.containerStackView.bottomAnchor).isActive = true
        self.containerStackView.axis = .vertical
    }
    
    
}
