//
//  MainViewController.swift
//  RxSwiftTest
//
//  Created by 조성민 on 3/1/25.
//

import UIKit

final class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        navigationItem.title = "화면 터치"
    }
    
    @objc private func tapped() {
        navigationController?.pushViewController(HotColdObservableViewController(), animated: true)
    }
}
