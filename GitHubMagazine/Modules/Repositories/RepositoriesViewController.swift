//
//  RepositoriesViewController.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
  private let tableView = UITableView()
  private let viewModel = RepositoriesViewModel()
  private let disposeBag = DisposeBag()
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  private let errorLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupView()
    setupBindings()
    viewModel.fetchRepositories()
  }
  
  private func setupNavigationBar() {
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.backgroundColor = .black
      appearance.titleTextAttributes = [
        .foregroundColor: UIColor.white
      ]
      
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
    } else {
      navigationController?.navigationBar.barTintColor = .black
    }
  }
  
  private func setupView() {
    title = "Repositórios Swift"
    view.addSubview(tableView)
    view.addSubview(activityIndicator)
    view.addSubview(errorLabel)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
    tableView.delegate = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    errorLabel.textColor = .red
    errorLabel.isHidden = true
  }
  
  private func setupBindings() {
    viewModel.repositoriesObservable
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.identifier, cellType: RepositoryCell.self)) { (row, repository, cell) in
        cell.configure(with: repository)
      }
      .disposed(by: disposeBag)
    
    viewModel.repositoriesObservable
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] repositories in
        self?.tableView.reloadData()
      })
      .disposed(by: disposeBag)
    
    viewModel.isLoading
      .observe(on: MainScheduler.instance)
      .bind(to: activityIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    viewModel.error
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] error in
        if let error = error {
          self?.errorLabel.text = error.localizedDescription
          self?.errorLabel.isHidden = false
        } else {
          self?.errorLabel.isHidden = true
        }
      })
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Repository.self)
      .subscribe(onNext: { [weak self] repository in
        let pullRequestsVC = PullRequestsViewController()
        pullRequestsVC.pullsUrl = repository.pulls_url.replacingOccurrences(of: "{/number}", with: "")
        pullRequestsVC.repositoryName = repository.name
        self?.navigationController?.pushViewController(pullRequestsVC, animated: true)
      })
      .disposed(by: disposeBag)
    
    tableView.rx.contentOffset
      .filter { $0.y > self.tableView.contentSize.height - self.tableView.frame.size.height - 100 }
      .subscribe(onNext: { [weak self] _ in
        self?.viewModel.fetchRepositories()
      })
      .disposed(by: disposeBag)
  }
}

extension RepositoriesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
