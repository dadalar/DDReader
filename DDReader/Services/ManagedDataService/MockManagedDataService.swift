//
//  MockManagedDataService.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift

final class MockManagedDataService: ManagedDataServicing {
    enum MockManagedDataServiceError: Error, DisplayableError {
        case someError

        var title: String? {
            return "Mock Error Title"
        }

        var message: String {
            return "Mock Error Message"
        }
    }

    func getPosts() -> Single<CachedPostsResponse> {
        if ProcessInfo.processInfo.environment["UI_TESTING_ERROR"] == "1" {
            return .error(MockManagedDataServiceError.someError)
        } else {
            let post1 = Post(userId: 0,
                             id: 0,
                             title: "Title 1",
                             body: "Body 1")
            let post2 = Post(userId: 0,
                             id: 0,
                             title: "Title 2",
                             body: "Body 2")
            let post3 = Post(userId: 0,
                             id: 0,
                             title: "Title 3",
                             body: "Body 3")
            let response = CachedPostsResponse(isCached: true, posts: [post1, post2, post3])
            return .just(response)
        }
    }

    func getDetails(for postId: UInt64) -> Single<PostDetail> {
        let post = Post(userId: 0,
                        id: 0,
                        title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                        body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto") //swiftlint:disable:this line_length
        let user = User(id: 0,
                        name: "Deniz Adalar",
                        username: "dadalar")
        let postDetail = PostDetail(post: post, user: user, comments: [])
        return .just(postDetail)
    }

}
