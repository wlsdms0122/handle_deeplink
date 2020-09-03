//
//  MainView.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    // MARK: - Layout
    let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let deferredButton: UIButton = {
        let view = UIButton()
        view.setTitle("Deferred Handle", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let deeplinkButton: UIButton = {
        let view = UIButton()
        view.setTitle("deeplink://route/present", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, deferredButton, deeplinkButton])
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 12
        
        deferredButton.snp.makeConstraints {
            $0.width.equalTo(180)
        }
        
        deeplinkButton.snp.makeConstraints {
            $0.width.equalTo(220)
        }
        
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
    
    // MARK: - Lifecycle
    override func draw(_ rect: CGRect) {
        
    }
    
    // MARK: - Private
    private func setUpLayout() {
        backgroundColor = .systemBackground
        
        [contentStackView].forEach { addSubview($0) }
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
