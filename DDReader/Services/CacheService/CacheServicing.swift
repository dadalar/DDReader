//
//  CacheServicing.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

enum CacheServicingCacheKey: String {
    case posts, users, comments
}

protocol CacheServicing {
    func save(_ key: CacheServicingCacheKey, data: Data) throws
    func read(_ key: CacheServicingCacheKey) throws -> Data
}

extension CacheServicing {
    func save<T: Codable>(_ key: CacheServicingCacheKey, value: T) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(value)
        try save(key, data: data)
    }

    func read<T: Codable>(_ key: CacheServicingCacheKey) throws -> T {
        let decoder = JSONDecoder()
        let data: Data = try read(key)
        return try decoder.decode(T.self, from: data)
    }
}
