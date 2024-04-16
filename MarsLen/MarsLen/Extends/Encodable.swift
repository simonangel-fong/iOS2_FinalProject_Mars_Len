//
//  Encodable.swift
//  MarsLen
//
//  Created by Simon Fong on 16/04/2024.
//

import Foundation
extension Encodable{
    var toDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else{
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
