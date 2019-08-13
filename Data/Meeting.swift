//
//  Meeting.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

struct Meeting: Decodable {
    let timestamp: String
    let duration: String
    let coach_id: String
    
    static func localMeeting() -> Meeting {
        return FileDecoder.model(fileName: "next_meeting", returnType: Meeting.self)
    }
}
