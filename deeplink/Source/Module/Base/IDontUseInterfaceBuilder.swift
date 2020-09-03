//
//  RawView.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit

protocol IDontUseInterfaceBuilder where Self: UIViewController {
    associatedtype Root
}

extension IDontUseInterfaceBuilder  {
    var root: Root { view as! Root }
}
