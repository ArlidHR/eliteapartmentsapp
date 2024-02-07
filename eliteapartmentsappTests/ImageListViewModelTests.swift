//
//  ImageListViewModelTests.swift
//  eliteapartmentsappTests
//
//  Created by Arlid Henao Rueda on 6/02/24.
//

import XCTest
@testable import eliteapartmentsapp

final class ImageListViewModelTests: XCTestCase {
    var viewModel: ImageListViewModel!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = ImageListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }

    func testAddImage() throws {
        let initialImageCount = viewModel.images.count
        let testImage = UIImage(named: "testImage")!
        let imageData = testImage.jpegData(compressionQuality: 1.0)!
        viewModel.addImage(with: imageData)
        XCTAssertEqual(viewModel.images.count, initialImageCount + 1)
    }

    func testDeleteImage() throws {
        let testImage = UIImage(named: "testImage")!
        let imageData = testImage.jpegData(compressionQuality: 1.0)!
        viewModel.addImage(with: imageData)
        let initialImageCount = viewModel.images.count
        viewModel.deleteImage(at: [0])
        XCTAssertEqual(viewModel.images.count, initialImageCount - 1)
    }
}
