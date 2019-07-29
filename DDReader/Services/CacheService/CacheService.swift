//
//  CacheService.swift
//  DDReader
//
//  Created by Deniz Adalar on 07/04/2019.
//  Copyright © 2019 Dadalar It Software. All rights reserved.
//

import Foundation

final class DiskCacheService: CacheServicing {

    private let cacheFolderURL: URL

    private static func documentsURL() -> URL {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(fileURLWithPath: path)
    }

    init(cacheFolderURL: URL = documentsURL()) {
        self.cacheFolderURL = cacheFolderURL
    }

    func save(_ key: CacheServicingCacheKey, data: Data) throws {
        let url = cacheFolderURL.appendingPathComponent(key.rawValue)
        try data.write(to: url)
    }

    func read(_ key: CacheServicingCacheKey) throws -> Data {
        let url = cacheFolderURL.appendingPathComponent(key.rawValue)
        return try Data(contentsOf: url)
    }
}
