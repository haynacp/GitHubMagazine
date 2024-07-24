//
//  PullRequestsViewController.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class PullRequestsViewController: UIViewController {
  private let tableView = UITableView()
  private let viewModel = PullRequestsViewModel()
  private let disposeBag = DisposeBag()
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  private let errorLabel = UILabel()
  private let noPullRequestsLabel = UILabel()
  
  var repositoryName: String?
  var pullsUrl: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    
    if let repositoryName = repositoryName {
      title = repositoryName
    }
    
    setupView()
    setupBindings()
    
    if let pullsUrl = pullsUrl {
      viewModel.fetchPullRequests(from: pullsUrl)
    }
  }
  
  private func setupNavigationBar() {
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .black
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
    } else {
      navigationController?.navigationBar.barTintColor = .black
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    backButton.tintColor = .white
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc private func backButtonTapped() {
    navigationController?.popWithTransition()
  }
  
  private func setupView() {
    view.addSubview(tableView)
    view.addSubview(activityIndicator)
    view.addSubview(errorLabel)
    view.addSubview(noPullRequestsLabel)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    noPullRequestsLabel.translatesAutoresizingMaskIntoConstraints = false
    
    noPullRequestsLabel.font = .systemFont(ofSize: 16)
    noPullRequestsLabel.textColor = .darkGray
    noPullRequestsLabel.text = "Não há pull requests abertos neste repositório."
    noPullRequestsLabel.isHidden = true
    
    tableView.register(PullRequestCell.self, forCellReuseIdentifier: PullRequestCell.identifier)
    tableView.delegate = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      noPullRequestsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      noPullRequestsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    errorLabel.textColor = .red
    errorLabel.isHidden = true
  }
  
  private func setupBindings() {
    viewModel.pullRequestsObservable
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: PullRequestCell.identifier, cellType: PullRequestCell.self)) { (row, pullRequest, cell) in
        cell.configure(with: pullRequest)
      }
      .disposed(by: disposeBag)
    
    viewModel.pullRequestsObservable
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] pullRequests in
        self?.tableView.reloadData()
        self?.noPullRequestsLabel.isHidden = !pullRequests.isEmpty
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
    
    tableView.rx.modelSelected(PullRequestsResponse.self)
      .subscribe(onNext: { [weak self] pullRequest in
        let webViewController = WebViewController()
        webViewController.urlString = pullRequest.html_url
        webViewController.modalPresentationStyle = .pageSheet
        if let sheet = webViewController.sheetPresentationController {
          sheet.detents = [.medium(), .large()]
        }
        self?.present(webViewController, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

extension PullRequestsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
