//
//  NetworkService.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkServicing {
    func data(request: URLRequest) -> Observable<Data>
}

extension Reactive: NetworkServicing where Base: URLSession { }
