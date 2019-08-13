//
//  LoginViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/11/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let start = ButtonStyler.button(text: "Login")
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(start)
        
        start.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.greaterThanOrEqualTo(100)
        }
        
        start.rx.tap.subscribe { [weak self] _ in
            LoginController.shared.login()
            self?.navigationController?.push(HomeViewController())
        }.disposed(by: disposeBag)
    }

}
