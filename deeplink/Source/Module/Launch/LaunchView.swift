//
//  LaunchView.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit
import SnapKit

class LaunchView: UIView {
    // MARK: - Layout
    let launchLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    // MARK: - Property
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setUpLayout() {
        backgroundColor = .systemGray
        
        [launchLabel].forEach { addSubview($0) }
        launchLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
