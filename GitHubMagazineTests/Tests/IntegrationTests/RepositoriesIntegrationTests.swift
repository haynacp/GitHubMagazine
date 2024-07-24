//
//  RepositoriesIntegrationTests.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import XCTest
import RxSwift
import RxCocoa
@testable import GitHubMagazine

class RepositoriesIntegrationTests: XCTestCase {
  
  var viewModel: RepositoriesViewModel!
  var disposeBag: DisposeBag!
  
  override func setUp() {
    super.setUp()
    viewModel = RepositoriesViewModel(apiService: APIService())
    disposeBag = DisposeBag()
  }
  
  override func tearDown() {
    viewModel = nil
    disposeBag = nil
    super.tearDown()
  }
  
  func testFetchRepositories() {
    // Arrange
    let expectation = XCTestExpectation(description: "Repositories fetched successfully")
    
    // Act
    viewModel.fetchRepositories()
    
    // Assert
    viewModel.repositoriesObservable
      .skip(1)
      .subscribe(onNext: { repositories in
        XCTAssertGreaterThan(repositories.count, 0)
        expectation.fulfill()
      })
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 10.0)
  }
}
