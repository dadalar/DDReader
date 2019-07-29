//
//  PostDetail.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct PostDetail {
    let post: Post
    let user: User
    let comments: [Comment]
}

extension PostDetail: Equatable { }
