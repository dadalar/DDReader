//
//  Comment.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let postId: UInt64
    let id: UInt64
    let name: String
    let email: String
    let body: String
}

extension Comment: Equatable { }
