//
//  UIViewController+Extension.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Application 의 최상위 view controller
    static var topMostViewController: UIViewController? { Self.allControllers.last }
    
    /// Application 의 전체 view controller stack
    static var allControllers: [UIViewController] {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return [] }
        var viewControllers = rootViewController.subControllers
        
        // Root view controller 로 부터 시작하여 `present` 된 view controller 에 대한 계층을 순회
        var viewController = rootViewController
        while let presented = viewController.presentedViewController {
            viewControllers += presented.subControllers
            viewController = presented
        }
        
        return viewControllers
    }
    
    /// UIViewController 의 children 에 해당하는 view controller 부분 집합을 구함
    private var subControllers: [UIViewController] {
        children.reduce([self]) { $0 + $1.subControllers }
    }
}
