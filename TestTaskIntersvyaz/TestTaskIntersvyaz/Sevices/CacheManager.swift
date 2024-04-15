//
//  CacheManager.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import Foundation
import Alamofire
import AlamofireImage


final class CacheManager {
    
    private init() {}
    static let shared = CacheManager()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
