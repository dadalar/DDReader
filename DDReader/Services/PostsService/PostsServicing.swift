//
//  NetworkService.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift

typealias PostsResponse = [Post]

protocol PostsServicing {
    func getPosts() -> Single<PostsResponse>
}
