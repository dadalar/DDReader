//
//  Post.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: UInt64
    let id: UInt64
    let title: String
    let body: String
}

extension Post: Equatable { }
