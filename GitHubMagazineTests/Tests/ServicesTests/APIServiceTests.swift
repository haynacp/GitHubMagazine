//
//  APIServiceTests.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import XCTest
import RxSwift
import RxBlocking
@testable import GitHubMagazine

class APIServiceTests: XCTestCase {
  
  var apiService: APIService!
  
  override func setUp() {
    super.setUp()
    apiService = APIService()
  }
  
  override func tearDown() {
    apiService = nil
    super.tearDown()
  }
  
  func testFetchRepositories() {
    let language = "Swift"
    let sortBy = "stars"
    let page = 1
    
    let repositories = try? apiService.fetchRepositories(language: language, sortBy: sortBy, page: page).toBlocking().first()
    
    XCTAssertNotNil(repositories)
    XCTAssertEqual(repositories?.items.count, 2)
  }
  
  func testFetchPullRequests() {
    let urlString = "https://api.github.com/repos/user/repo/pulls"
    
    let pullRequests = try? apiService.fetchPullRequests(from: urlString).toBlocking().first()
    
    XCTAssertNotNil(pullRequests)
    XCTAssertEqual(pullRequests?.count, 2)
  }
}
