//
//  ViewModel.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/2/25.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
