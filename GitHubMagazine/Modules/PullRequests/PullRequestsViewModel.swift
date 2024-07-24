//
//  PullRequestsViewModel.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Alamofire
import RxSwift
import RxCocoa

class PullRequestsViewModel {
  private let apiService: APIServiceProtocol
  private let disposeBag = DisposeBag()
  
  private let pullRequestsRelay = BehaviorRelay<[PullRequestsResponse]>(value: [])
  var pullRequestsObservable: Observable<[PullRequestsResponse]> {
    return pullRequestsRelay.asObservable()
  }
  
  private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
  var isLoading: Observable<Bool> {
    return isLoadingRelay.asObservable()
  }
  
  private let errorRelay = PublishRelay<Error?>()
  var error: Observable<Error?> {
    return errorRelay.asObservable()
  }
  
  init(apiService: APIServiceProtocol = APIService()) {
    self.apiService = apiService
  }
  
  func fetchPullRequests(from urlString: String) {
    isLoadingRelay.accept(true)
    
    apiService.fetchPullRequests(from: urlString)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] pullRequests in
        self?.isLoadingRelay.accept(false)
        self?.pullRequestsRelay.accept(pullRequests)
        self?.errorRelay.accept(nil)
      }, onError: { [weak self] error in
        self?.isLoadingRelay.accept(false)
        self?.errorRelay.accept(error)
      })
      .disposed(by: disposeBag)
  }
}
