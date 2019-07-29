//
//  User.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: UInt64
    let name: String
    let username: String
}

extension User: Equatable { }
