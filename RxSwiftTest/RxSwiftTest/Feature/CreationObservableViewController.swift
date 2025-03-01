//
//  CreationObservableViewController.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/1/25.
//

import UIKit
import SnapKit
import RxSwift

final class CreationObservableViewController: UIViewController {
    private let viewModel = CreationObservableViewModel()
    private let disposeBag = DisposeBag()
    
    private let button: UIButton = {
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
        bind()
    }
    
    private func configureHierarchy() {
        view.addSubview(button)
    }
    
    private func configureLayout() {
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .white
    }
    
    private func bind() {
        let output = viewModel.transform(
            input: CreationObservableViewModel.Input(
                startButtonTapped: button.rx.tap
            )
        )
        
        output.create
            .subscribe(with: self) { owner, value in
                print("created: \(value)")
            } onDisposed: { owner in
                print("create disposed")
            }
            .disposed(by: disposeBag)
        
        output.asyncCreate
            .subscribe(with: self) { owner, value in
                print("asyncCreate: \(value)")
            } onDisposed: { owner in
                print("asyncCreate disposed")
            }
            .disposed(by: disposeBag)
        
        output.from
            .subscribe(with: self) { owner, value in
                print("from: \(value)")
            } onDisposed: { owner in
                print("from disposed")
            }
            .disposed(by: disposeBag)
        
        output.of
            .subscribe(with: self) { owner, value in
                print("of: \(value)")
            } onDisposed: { owner in
                print("of disposed")
            }
            .disposed(by: disposeBag)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
}
