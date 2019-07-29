//
//  PostDetailModel.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import UIKit

struct PostDetailModel {
    let title: String
    let body: String
    let author: NSAttributedString
    let commentCountText: String
}

extension PostDetailModel {
    private static func authorAttributesText(name: String, username: String) -> NSAttributedString {
        /*
         Author label text format:
         Name
         @Username
         */
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: name,
                                       attributes: [.font: UIFont.preferredFont(forTextStyle: .title2)]))
        text.append(NSAttributedString(string: "\n"))
        text.append(NSAttributedString(string: "@\(username)",
                                       attributes: [.font: UIFont.preferredFont(forTextStyle: .title3)]))
        return text
    }

    init(postDetail: PostDetail) {
        title = postDetail.post.title
        body = postDetail.post.body
        author = PostDetailModel.authorAttributesText(name: postDetail.user.name, username: postDetail.user.username)
        commentCountText = "Comments: \(postDetail.comments.count)"
    }
}
