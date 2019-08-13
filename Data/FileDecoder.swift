//
//  FileDecoder.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import Foundation

struct FileDecoder {
    
    static func model<T: Decodable>(_ returnType: T.Type) -> T {
        return FileDecoder.model(fileName: String(describing: T.self), returnType: T.self)
    }
    
    static func model<T: Decodable>(bundle: Bundle = Bundle.main, fileName: String, returnType: T.Type) -> T {
        guard let pathString = bundle.path(forResource: fileName, ofType: "json") else {
            fatalError("\(fileName).json not found")
        }
        guard let data = FileManager.default.contents(atPath: pathString) else {
            fatalError("File data could not be read")
        }
        
        do {
            return try JSONDecoder().decode(returnType, from: data)
        } catch {
            print(error)
            fatalError("Model parsing error")
        }
    }
}
