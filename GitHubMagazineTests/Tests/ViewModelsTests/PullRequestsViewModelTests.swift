//
//  PullRequestsViewModelTests.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import GitHubMagazine

class PullRequestsViewModelTests: XCTestCase {
    
    var viewModel: PullRequestsViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = PullRequestsViewModel(apiService: MockAPIService())
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testFetchPullRequestsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Pull Requests fetched successfully")
        
        // Act
        viewModel.fetchPullRequests(from: "https://api.github.com/repos/vsouza/awesome-ios/pulls")
        
        // Assert
        viewModel.pullRequestsObservable
            .skip(1)
            .subscribe(onNext: { pullRequests in
                XCTAssertEqual(pullRequests.count, 2)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchPullRequestsFailure() {
        // Arrange
        let expectation = XCTestExpectation(description: "Pull Requests fetch failed")
        viewModel = PullRequestsViewModel(apiService: MockAPIServiceWithError())
        
        // Act
        viewModel.fetchPullRequests(from: "https://api.github.com/repos/vsouza/awesome-ios/pulls")
        
        // Assert
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
