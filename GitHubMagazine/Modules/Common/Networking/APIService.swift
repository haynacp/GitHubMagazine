//
//  APIService.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation
import RxSwift

class APIService: APIServiceProtocol {
    private let baseURL = "https://api.github.com"
    
    func fetchRepositories(language: String, sortBy: String, page: Int) -> Observable<RepositoriesResponse> {
        let urlString = "\(baseURL)/search/repositories?q=language:\(language)&sort=\(sortBy)&page=\(page)"
        guard let url = URL(string: urlString) else {
            return Observable.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(RepositoriesResponse.self, from: data)
                    observer.onNext(response)
                    observer.onCompleted()
                } catch let decodeError {
                    observer.onError(decodeError)
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchPullRequests(from urlString: String) -> Observable<[PullRequestsResponse]> {
        guard let url = URL(string: urlString) else {
            return Observable.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pullRequests = try decoder.decode([PullRequestsResponse].self, from: data)
                    observer.onNext(pullRequests)
                    observer.onCompleted()
                } catch let decodeError {
                    observer.onError(decodeError)
                }
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
