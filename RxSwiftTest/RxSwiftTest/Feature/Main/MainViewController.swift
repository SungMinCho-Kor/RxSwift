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
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    @objc private func tapped() {
        navigationController?.pushViewController(CreationObservableViewController(), animated: true)
    }
}
