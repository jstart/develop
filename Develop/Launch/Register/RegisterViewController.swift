//
//  RegisterViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/11/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class RegisterViewController: UIViewController {
    let question = UILabel(translates: false)
    let field = UITextField(translates: false)
    let submit = ButtonStyler.button(text: "Next")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(question, field, submit)
        
        question.text = "What's your name?"
        question.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.greaterThanOrEqualTo(200)
        }
        
        field.textContentType = .name
        field.backgroundColor = .lightGray
        field.snp.makeConstraints { make in
            make.top.equalTo(question.snp.bottom).offset(50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.greaterThanOrEqualTo(200)
        }
        
        submit.snp.makeConstraints { make in
            make.top.equalTo(field.snp.bottom).offset(50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.greaterThanOrEqualTo(200)
        }
        
        submit.rx.tap.subscribe { [weak self] _ in
            self?.navigationController?.push(VerifyPhoneViewController())
        }.disposed(by: disposeBag)
        
    }

}
