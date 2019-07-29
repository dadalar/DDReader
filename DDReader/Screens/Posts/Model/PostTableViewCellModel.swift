//
//  PostTableViewCellModel.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct PostTableViewCellModel {
    let id: UInt64
    let title: String
    let subtitle: String
}

extension PostTableViewCellModel {

    init(post: Post) {
        id = post.id
        title = post.title
        subtitle = post.body.replacingOccurrences(of: "\n", with: " ")
    }

}
