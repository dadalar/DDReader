//
//  PostsViewModel.swift
//  DDReader
//
//  Created by Deniz Adalar on 05/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PostsViewModel {

    // MARK: Public properties
    let posts = PublishRelay<CachedPostsResponse>() // Observable data
    let isLoading = PublishRelay<Bool>() // Observable isLoading
    let error = PublishRelay<Error>() // Observable error
    let needsUpdate = PublishRelay<Void>() // Triggers data update

    // MARK: Private properties
    private let disposeBag = DisposeBag()

    // MARK: Initialization
    init(managedDataService: ManagedDataServicing) {
        needsUpdate
            .do(onNext: { [isLoading] in
                isLoading.accept(true) // Set isLoading to true
            })
            .flatMap(managedDataService.getPosts) // Fetch data
            .do(onNext: { [isLoading] _ in
                isLoading.accept(false) // Set isLoading to false when successful
            })
            .do(onError: { [error, isLoading] in
                error.accept($0) // Send error signal
                isLoading.accept(false) // Set isLoading to false when failed
            })
            .retry() // Retry needsUpdate in case of error
            .subscribe(onNext: posts.accept) // Push data into posts (only if successful)
            .disposed(by: disposeBag)
    }

}
