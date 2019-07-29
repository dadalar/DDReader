//
//  PostsService.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PostsService: PostsServicing {
    private static let jsonDecoder = JSONDecoder()

    let baseURL: URL
    let networkService: NetworkServicing

    init(baseURL: URL,
         networkService: NetworkServicing = URLSession.shared.rx) {
        self.baseURL = baseURL
        self.networkService = networkService
    }

    func getPosts() -> Single<PostsResponse> {
        let request = URLRequest(url: baseURL.appendingPathComponent("posts"))
        return networkService.data(request: request)
            .asSingle()
            .map { try PostsService.jsonDecoder.decode(PostsResponse.self, from: $0) }
    }
}
