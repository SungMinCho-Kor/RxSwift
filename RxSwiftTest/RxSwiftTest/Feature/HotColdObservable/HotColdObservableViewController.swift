//
//  HotColdObservableViewController.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/2/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HotColdObservableViewController: BaseViewController {
    private func coldFrom() {
        let coldFrom = Observable.from([1, 3, 5, 9])
        
        coldFrom.subscribe { value in
            print(value)
        } onDisposed: {
            print(#function, "Disposed")
        }
        .disposed(by: disposeBag)
        
        coldFrom.subscribe { value in
            print(value)
        } onDisposed: {
            print(#function, "Disposed")
        }
        .disposed(by: disposeBag)
    }
    
    private func coldCreate() {
        let coldCreate = Observable<Int>.create { observer in
            observer.onNext(2)
            observer.onNext(4)
            observer.onNext(6)
            observer.onNext(8)
            observer.onCompleted()
            return Disposables.create()
        }
        
        coldCreate.subscribe { value in
            print(value)
        } onDisposed: {
            print(#function, "Disposed")
        }
        .disposed(by: disposeBag)
        
        coldCreate.subscribe { value in
            print(value)
        } onDisposed: {
            print(#function, "Disposed")
        }
        .disposed(by: disposeBag)
    }
    
    private func hotPublishRelay() {
        let hotPublishRelay = PublishRelay<Int>()
        
        hotPublishRelay.accept(1)
        hotPublishRelay.accept(3)
        hotPublishRelay.accept(5)
        hotPublishRelay.accept(9)
        
        hotPublishRelay.bind { value in
            print(value)
        }
        .disposed(by: disposeBag)
        
        hotPublishRelay.accept(2)
        hotPublishRelay.accept(4)
        hotPublishRelay.accept(6)
        hotPublishRelay.accept(8)
    }
    
    private func hotBehaviorSubject() {
        let hotBehaviorSubject = BehaviorSubject<Int>(value: 1)
        
        hotBehaviorSubject.onNext(3)
        hotBehaviorSubject.onNext(5)
        hotBehaviorSubject.onNext(7)
        
        hotBehaviorSubject.subscribe { value in
            print(value)
        } onDisposed: {
            print(#function, "Disposed")
        }
        .disposed(by: disposeBag)
        
        hotBehaviorSubject.onNext(2)
        hotBehaviorSubject.onNext(4)
        hotBehaviorSubject.onNext(6)
        hotBehaviorSubject.onCompleted()
        hotBehaviorSubject.onNext(8)
    }
    
    override func bind() {
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.coldFrom()
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.coldCreate()
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.hotPublishRelay()
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                owner.hotBehaviorSubject()
            }
            .disposed(by: disposeBag)
    }
}
