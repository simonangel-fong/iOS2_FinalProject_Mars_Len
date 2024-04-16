//
//  DatabaseExtends.swift
//  MarsLen
//
//  Created by Simon Fong on 15/04/2024.
//

import Foundation
import FirebaseDatabase

extension Database {
    ///Return a ref to our database
    class var root: DatabaseReference {
        return database().reference()
    }
}

