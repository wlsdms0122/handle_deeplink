//
//  LaunchViewController.swift
//  deeplink
//
//  Created by Mackey on 2020/08/31.
//  Copyright © 2020 Mackey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct LaunchViewModel {
    
}

class LaunchViewController: UIViewController, IDontUseInterfaceBuilder {
    typealias Root = LaunchView
    
    enum Constant {
        static let countdown = 3
    }
    
    // MARK: - Layout
    private var launchLabel: UILabel { root.launchLabel }
    
    // MARK: - Property
    private let urlController: URLHandler
    private(set) var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(urlController: URLHandler) {
        self.urlController = urlController
        super.init(nibName: nil, bundle: nil)
        
        setUpLayout(LaunchViewModel())
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = LaunchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Private
    private func setUpLayout(_ viewModel: LaunchViewModel) {
        launchLabel.text = "🚀 \(Constant.countdown)초 후 Main 으로 이동."
    }
    
    private func bind() {
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(Constant.countdown)
            .map { Constant.countdown - ($0 + 1) }
            .subscribe(
                onNext: { [weak self] in self?.launchLabel.text = "🚀 \($0)초 후 Main 으로 이동." },
                onCompleted: { [weak self] in self?.present(main: "Main") }
            )
            .disposed(by: disposeBag)
    }
    
    private func present(main title: String) {
        let viewController = MainViewController(urlController: urlController, title: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true, completion: nil)
    }
}

 
