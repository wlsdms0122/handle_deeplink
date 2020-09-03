//
//  MainViewController.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct MainViewModel {
    let title: String
}

class MainViewController: UIViewController, IDontUseInterfaceBuilder {
    typealias Root = MainView
    
    // MARK: - Layout
    private var titleLabel: UILabel { root.titleLabel }
    private var deferredButton: UIButton { root.deferredButton }
    private var deeplinkButton: UIButton { root.deeplinkButton }
    
    // MARK: - Property
    private let urlController: URLHandler
    let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(urlController: URLHandler, title: String) {
        self.urlController = urlController
        super.init(nibName: nil, bundle: nil)
        
        setUpLayout(MainViewModel(title: title))
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        _ = urlController.handle()
    }
    

    // MARK: - Private
    private func setUpLayout(_ viewModel: MainViewModel) {
        titleLabel.text = viewModel.title
    }
    
    private func bind() {
        deferredButton.rx.tap
            .subscribe(onNext: { [weak self] in _ = self?.urlController.handle() })
            .disposed(by: disposeBag)
        
        deeplinkButton.rx.tap
            .subscribe(onNext: { [weak self] in _ = self?.urlController.handle(string: "deeplink://route/present?title=kenken") })
            .disposed(by: disposeBag)
    }
}

