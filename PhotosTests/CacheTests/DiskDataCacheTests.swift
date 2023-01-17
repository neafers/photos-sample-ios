//
//  DiskDataCacheTests.swift
//  PhotosTests
//
//  Created by jeff on 11/8/20.
//

import XCTest
@testable import Photos

class DiskDataCacheTests: XCTestCase {

    var data: Data!
    var cache: DiskDataCache!
    
    override func setUp() {
        data = TestNames.cachedData.data(using: .utf8)
        cache = DiskDataCache()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCacheUrl() {
        XCTAssertNotNil(cache.cacheURL)
        XCTAssertEqual(cache.cacheURL, FileManager.imageCacheURL())
    }

    func testCacheData() {
        
        let exp = expectation(description: "Expect cache to complete.")
        
        cache.cache(data: data, named: TestNames.cachedData, completion: {
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testRetrieveCachedData() {
        let cached = cache.cachedData(named: TestNames.cachedData)
        XCTAssertNotNil(cached)
        let string = String(data: cached!, encoding: .utf8)
        XCTAssertEqual(string, TestNames.cachedData)
    }
}
