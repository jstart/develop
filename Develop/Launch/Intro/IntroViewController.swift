//
//  IntroViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/11/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class IntroViewController: UIViewController {

    let logo = UILabel(translates: false)
    let login = UIButton(translates: false)
    let info = UILabel(translates: false)
    let start = ButtonStyler.button(text: "Get Started")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(logo, login, info, start)
        
        logo.text = "Develop"
        logo.font = .boldSystemFont(ofSize: 24)
        
        logo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        login.setTitle("login", for: .normal)
        login.setTitleColor(.black, for: .normal)
        
        login.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-15)
        }
        
        login.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.push(LoginViewController())
        }.disposed(by: disposeBag)

        info.numberOfLines = 0
        info.textAlignment = .center
        info.text = """
            Career coaching for engineers.
            Learn from the best
            and get inspired to be your best.
        """
        
        info.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(200)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(start.snp.top).offset(-20)
        }
        
        start.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.greaterThanOrEqualTo(100)
        }
        
        start.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.push(RegisterViewController())
        }.disposed(by: disposeBag)
    }

}
