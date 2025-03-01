//
//  BaseViewController.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/2/25.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController  {
    let disposeBag = DisposeBag()
    
    let button: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Start"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .black
        button.configuration = configuration
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print(#function, self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function, self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureViews()
        configureNavigtaion()
        bind()
    }
    
    func configureHierarchy() {
        view.addSubview(button)
    }
    
    func configureLayout() {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    func configureViews() {
        view.backgroundColor = .white
    }
    
    func configureNavigtaion() {
        navigationItem.title = String(describing: self)
    }
    
    func bind() { }
}
