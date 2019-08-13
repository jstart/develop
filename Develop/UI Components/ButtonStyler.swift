//
//  ButtonStyler.swift
//  Develop
//
//  Created by Truman, Christopher on 8/9/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

struct ButtonStyler {
    
    static func button(text: String) -> UIButton {
        return UIButton().then {
            $0.setTitle(text, for: .normal)
            $0.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.round(radius: 5)
            $0.backgroundColor = .lightGray
        }
    }

}
