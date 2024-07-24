//
//  MockAPIService.swift
//  GitHubMagazineTests
//
//  Created by Hayna Cardoso on 23/07/24.
//

import RxSwift
@testable import GitHubMagazine

import RxSwift

class MockAPIService: APIServiceProtocol {
  func fetchRepositories(language: String, sortBy: String, page: Int) -> Observable<RepositoriesResponse> {
    let mockRepositories = [
      Repository(id: 1, name: "Repo1", full_name: "FullRepo1", owner: Owner(login: "Owner1", avatar_url: ""), description: "Description1", stargazers_count: 100, forks_count: 50, html_url: "", pulls_url: ""),
      Repository(id: 2, name: "Repo2", full_name: "FullRepo2", owner: Owner(login: "Owner2", avatar_url: ""), description: "Description2", stargazers_count: 200, forks_count: 100, html_url: "", pulls_url: "")
    ]
    let mockResponse = RepositoriesResponse(items: mockRepositories)
    return Observable.just(mockResponse)
  }
  
  func fetchPullRequests(from urlString: String) -> Observable<[PullRequestsResponse]> {
    let mockPullRequests = [
      PullRequestsResponse(title: "PR1", body: "Body1", user: PullRequestsResponse.User(login: "User1", avatar_url: ""), html_url: ""),
      PullRequestsResponse(title: "PR2", body: "Body2", user: PullRequestsResponse.User(login: "User2", avatar_url: ""), html_url: "")
    ]
    return Observable.just(mockPullRequests)
  }
}
