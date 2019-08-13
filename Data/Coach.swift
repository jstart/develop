//
//  Coach.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

struct Coach: Decodable {
    let guid: String
    let name: String
    let profile_photo: String
    let company: String
    let job_title: String

    let tags: [String]
    let skills: [String]
    let minimum_price: Int
    let client_availability: Int
    let bio: String
    let video: String
    
    static func localCoaches() -> [Coach] {
        return FileDecoder.model(fileName: "coaches", returnType: [Coach].self)
    }
}
