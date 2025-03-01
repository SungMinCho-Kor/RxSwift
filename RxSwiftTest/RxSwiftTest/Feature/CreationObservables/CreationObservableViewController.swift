//
//  CreationObservableViewController.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/1/25.
//

import UIKit
import SnapKit
import RxSwift

final class CreationObservableViewController: BaseViewController {
    private let viewModel = CreationObservableViewModel()
    
    override func bind() {
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
        
        output.just
            .subscribe(with: self) { owner, value in
                print("just: \(value)")
            } onDisposed: { owner in
                print("just disposed")
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
