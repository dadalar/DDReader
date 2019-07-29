//
//  CachedPostsResponse.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

struct CachedPostsResponse {
    let isCached: Bool
    let posts: PostsResponse
}

extension CachedPostsResponse: Equatable { }
