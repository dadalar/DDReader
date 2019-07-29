//
//  ManagedDataServicing.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift

protocol ManagedDataServicing {
    func getPosts() -> Single<CachedPostsResponse>
    func getDetails(for postId: UInt64) -> Single<PostDetail>
}
