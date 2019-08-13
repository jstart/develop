//
//  VerifyPhoneViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/11/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import RxSwift

class VerifyPhoneViewController: UIViewController {
    let code = UITextField(translates: false)

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(code)
        
        code.textContentType = .oneTimeCode
        code.backgroundColor = .lightGray
        
        code.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(200)
        }
        code.rx.text.filter { string in
            return string?.count ?? 0 >= 4
        }
        .first()
        .subscribe { _ in
            NotificationCenter.post(name: LoginObserver.RegisteredNotification)
        }.disposed(by: disposeBag)
    }

}
