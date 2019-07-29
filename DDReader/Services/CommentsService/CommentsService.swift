//
//  CommentsService.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CommentsService: CommentsServicing {
    private static let jsonDecoder = JSONDecoder()

    let baseURL: URL
    let networkService: NetworkServicing

    init(baseURL: URL,
         networkService: NetworkServicing = URLSession.shared.rx) {
        self.baseURL = baseURL
        self.networkService = networkService
    }

    func getComments() -> Single<CommentsResponse> {
        let request = URLRequest(url: baseURL.appendingPathComponent("comments"))
        return networkService.data(request: request)
            .asSingle()
            .map { try CommentsService.jsonDecoder.decode(CommentsResponse.self, from: $0) }
    }
}
