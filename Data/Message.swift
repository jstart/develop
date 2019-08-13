//
//  Message.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

struct Message: Decodable {
    let content: String
    let timestamp: String
    let metadata: [String: String]
    let author: String
    
    static func localMessages() -> [Message] {
        return FileDecoder.model(fileName: "coach_messages", returnType: [Message].self)
    }
}
