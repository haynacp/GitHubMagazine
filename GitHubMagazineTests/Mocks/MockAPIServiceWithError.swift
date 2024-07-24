//
//  MockAPIServiceWithError.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import RxSwift
@testable import GitHubMagazine

class MockAPIServiceWithError: APIServiceProtocol {
  func fetchRepositories(language: String, sortBy: String, page: Int) -> Observable<RepositoriesResponse> {
    return Observable.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"]))
  }
  
  func fetchPullRequests(from urlString: String) -> Observable<[PullRequestsResponse]> {
    return Observable.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"]))
  }
}
