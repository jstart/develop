//
//  UserTableViewCell.swift
//  Develop
//
//  Created by Truman, Christopher on 8/10/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import SnapKit

class UserTableViewCell: UITableViewCell {

    let profileImage = UIImageView(translates: false)
    let name = UILabel(translates: false)
    let edit = ButtonStyler.button(text: "Edit")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(profileImage, name, edit)
        
        profileImage.backgroundColor = .lightGray
        profileImage.round(radius: 50/2)
        
        profileImage.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.top.equalTo(contentView.snp.topMargin).offset(5)
            make.bottom.equalTo(contentView.snp.bottomMargin).offset(-5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        name.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.topMargin).offset(5)
            make.bottom.equalTo(contentView.snp.bottomMargin).offset(-5)
        }
        
        edit.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView.snp.trailingMargin)
            make.centerY.equalTo(contentView.snp.centerYWithinMargins)
            make.width.equalTo(100)
        }
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        name.text = nil
    }
    
    func configure(_ user: User) {
        name.text = user.name
    }
    
}
