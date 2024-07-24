//
//  RepositoriesViewModel.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import RxSwift
import RxCocoa

class RepositoriesViewModel {
  private let apiService: APIServiceProtocol
  private let disposeBag = DisposeBag()
  
  private let repositoriesRelay = BehaviorRelay<[Repository]>(value: [])
  var repositoriesObservable: Observable<[Repository]> {
    return repositoriesRelay.asObservable()
  }
  
  private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
  var isLoading: Observable<Bool> {
    return isLoadingRelay.asObservable()
  }
  
  private let errorRelay = PublishRelay<Error?>()
  var error: Observable<Error?> {
    return errorRelay.asObservable()
  }
  
  private var currentPage = 1
  private var isFetching = false
  
  init(apiService: APIServiceProtocol = APIService()) {
    self.apiService = apiService
  }
  
  func fetchRepositories() {
    guard !isFetching else { return }
    isFetching = true
    isLoadingRelay.accept(true)
    
    apiService.fetchRepositories(language: "Swift", sortBy: "stars", page: currentPage)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] response in
        guard let self = self else { return }
        self.isFetching = false
        self.isLoadingRelay.accept(false)
        self.currentPage += 1
        var repositories = self.repositoriesRelay.value
        repositories.append(contentsOf: response.items)
        self.repositoriesRelay.accept(repositories)
        self.errorRelay.accept(nil)
      }, onError: { [weak self] error in
        self?.isFetching = false
        self?.isLoadingRelay.accept(false)
        self?.errorRelay.accept(error)
      })
      .disposed(by: disposeBag)
  }
}
