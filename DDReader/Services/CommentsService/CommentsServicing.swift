//
//  PostsServicing.swift
//  DDReader
//
//  Created by Deniz Adalar on 06/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift

typealias CommentsResponse = [Comment]

protocol CommentsServicing {
    func getComments() -> Single<CommentsResponse>
}
