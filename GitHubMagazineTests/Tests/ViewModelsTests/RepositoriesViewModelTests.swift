//
//  RepositoriesViewModelTests.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import GitHubMagazine

class RepositoriesViewModelTests: XCTestCase {
  
  var viewModel: RepositoriesViewModel!
  var disposeBag: DisposeBag!
  
  override func setUp() {
    super.setUp()
    viewModel = RepositoriesViewModel(apiService: MockAPIService())
    disposeBag = DisposeBag()
  }
  
  override func tearDown() {
    viewModel = nil
    disposeBag = nil
    super.tearDown()
  }
  
  func testFetchRepositoriesSuccess() {
    let expectation = XCTestExpectation(description: "Repositories fetched successfully")
    
    viewModel.fetchRepositories()
    
    viewModel.repositoriesObservable
      .skip(1)
      .subscribe(onNext: { repositories in
        XCTAssertEqual(repositories.count, 2)
        expectation.fulfill()
      })
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchRepositoriesFailure() {
    let expectation = XCTestExpectation(description: "Repositories fetch failed")
    viewModel = RepositoriesViewModel(apiService: MockAPIServiceWithError())
    
    viewModel.fetchRepositories()
    
    viewModel.error
      .skip(1)
      .subscribe(onNext: { error in
        XCTAssertNotNil(error)
        expectation.fulfill()
      })
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 5.0)
  }
}
