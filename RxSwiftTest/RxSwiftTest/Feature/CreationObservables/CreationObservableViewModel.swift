//
//  CreationObservableViewModel.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/1/25.
//

import RxSwift
import RxCocoa
import Alamofire

final class CreationObservableViewModel: ViewModel {
    struct Input {
        let startButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let create: Observable<Int>
        let asyncCreate: Observable<Int>
        let from: Observable<Int>
        let of: Observable<Int>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let create = makeCreate()
//        let asyncCreate = makeAsyncCreate()
        let from = makeFrom()
        let of = makeOf()
        
        let asyncCreate = input.startButtonTapped
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.makeAsyncCreate()
            }
        
        let output = Output(
            create: create,
            asyncCreate: asyncCreate,
            from: from,
            of: of
        )
        
        return output
    }
    
    private func makeFrom() -> Observable<Int> {
        return Observable.from([1, 2, 3])
    }
    
    private func makeOf() -> Observable<Int> {
        return Observable.of(1, 2, 3)
    }
    
    private func makeCreate() -> Observable<Int> {
        return Observable<Int>.create { observer in
            for i in 1...3 {
                observer.onNext(i)
            }
            observer.onCompleted()
            return Disposables.create {
                print(#function, "Disposed")
            }
        }
    }
    
    private func makeAsyncCreate() -> Observable<Int> {
        return Observable<Int>.create { observer in
            AF.request("http://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=3")
                .responseDecodable(of: [Int].self) { response in
                    switch response.result {
                    case .success(let numbers):
                        numbers.forEach { observer.onNext($0) }
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                print(#function, "Disposed")
            }
        }
    }
}
