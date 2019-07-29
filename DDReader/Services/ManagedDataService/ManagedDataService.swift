//
//  ManagedDataService.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ManagedDataService: ManagedDataServicing {

    // Public types
    enum ManagedDataServiceError: Error {
        case notFound
    }

    // MARK: Private properties
    private var posts: [Post]?
    private var users: [UInt64: User]? // UserID -> User
    private var comments: [UInt64: [Comment]]? // PostId -> [Comment]

    private let postsService: PostsServicing
    private let usersService: UsersServicing
    private let commentsService: CommentsServicing
    private let cacheService: CacheServicing
    private let disposeBag = DisposeBag()

    init(postsService: PostsServicing,
         usersService: UsersServicing,
         commentsService: CommentsServicing,
         cacheService: CacheServicing) {
        self.postsService = postsService
        self.usersService = usersService
        self.commentsService = commentsService
        self.cacheService = cacheService
    }

    private func updateData() -> Single<CachedPostsResponse> {
        return Single
            .zip(
                postsService.getPosts(),
                usersService.getUsers(),
                commentsService.getComments()
            )
            .do(onSuccess: { [weak self] postsArray, usersArray, commentsArray in
                guard let self = self else { return }
                // Group elements by their id's with the assumption that their ids are unique
                self.posts = postsArray
                self.users = Dictionary(grouping: usersArray, by: { $0.id }).mapValues { $0.first! }
                self.comments = Dictionary(grouping: commentsArray, by: { $0.postId })

                // Cache values (and ignore errors)
                try? self.cacheService.save(.posts, value: self.posts)
                try? self.cacheService.save(.users, value: self.users)
                try? self.cacheService.save(.comments, value: self.comments)
            })
            .do(onError: { [weak self] _ in
                guard let self = self else { return }
                // Try reading from cache in case of an error
                if self.posts == nil,
                    let posts: [Post] = try? self.cacheService.read(.posts),
                    let users: [UInt64: User] = try? self.cacheService.read(.users),
                    let comments: [UInt64: [Comment]] = try? self.cacheService.read(.comments) {

                    self.posts = posts
                    self.users = users
                    self.comments = comments
                }
            })
            .map { CachedPostsResponse(isCached: false, posts: $0.0) }
    }

    func getPosts() -> Single<CachedPostsResponse> {
        return updateData()
            .catchError { [weak self] error in
                guard let posts = self?.posts else { return .error(error) }
                let response = CachedPostsResponse(isCached: true, posts: posts)
                return .just(response)
            }
    }

    func getDetails(for postId: UInt64) -> Single<PostDetail> {
        guard let post = posts?.first(where: { $0.id == postId }),
            let user = users?[post.userId],
            let commentsForPost = comments?[postId, default: []] else {
                return .error(ManagedDataServiceError.notFound)
        }

        let postDetail = PostDetail(post: post, user: user, comments: commentsForPost)
        return .just(postDetail)
    }

}
