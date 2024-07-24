//
//  APIServiceProtocol.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import RxSwift

protocol APIServiceProtocol {
    func fetchRepositories(language: String, sortBy: String, page: Int) -> Observable<RepositoriesResponse>
    func fetchPullRequests(from urlString: String) -> Observable<[PullRequestsResponse]>
}
