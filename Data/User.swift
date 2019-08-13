//
//  User.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

struct User: Decodable {
    let guid: String
    let name: String
    let email: String
    let phone: String
    let profile_photo: String
    let company: String
    let job_title: String
    let coach: Int
    let meeting_credits: Int
    let state: String
    let notifications_enabled: Bool
    let email_enabled: Bool
    
    static func localUser() -> User {
        return FileDecoder.model(User.self)
    }
}
