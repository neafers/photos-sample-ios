//
//  ImageListViewModelTests.swift
//  PhotosTests
//
//  Created by jeff on 11/8/20.
//

import XCTest
@testable import Photos

class ImageListViewModelTests: XCTestCase {

    var delegate: MockImageListViewModelDelegate!
    var imageProvider: MockImageProvider!
    var viewModel: ImageListViewModel!
    
    override func setUp() {
        delegate = MockImageListViewModelDelegate()
        imageProvider = MockImageProvider()
        viewModel = ImageListViewModel(imageProvider: imageProvider)
        viewModel.delegate = delegate
        let exp = expectation(description: "Downloading image list")
        let _ = XCTWaiter.wait(for: [exp], timeout: 5.0)
    }

    override func tearDown() {
        delegate = nil
        imageProvider = nil
        viewModel = nil
    }

    func testSetup() {
        XCTAssertNotNil(viewModel.imageProvider as? MockImageProvider)
        XCTAssertEqual(viewModel.imageList.count, 5000)
    }
    
    func testImageInfoForIndexPathStandard() {
        let info = viewModel.imageInfo(for: IndexPath(row: 2, section: 0))
        XCTAssertEqual(info.url.absoluteString, TestNames.image3HighQualityUrl)
        XCTAssertEqual(info.thumbnailUrl.absoluteString, TestNames.image3LowQualityUrl)
    }
    
    func testSectionCount() {
        XCTAssertEqual(viewModel.sectionCount(), 1)
    }
    
    func testItemCountStandard() {
        XCTAssertEqual(viewModel.itemCount(for: 0), viewModel.imageList.count)
    }
}
