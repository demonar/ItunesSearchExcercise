//
//  NavigationRouter.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import UIKit

class NavigationRouter {
    
    class func InitialScreen() -> UINavigationController {
        return UINavigationController(rootViewController: SearchContainerViewController())
    }
}
