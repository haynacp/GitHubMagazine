//
//  WebViewController.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
  var urlString: String?
  
  private var webView: WKWebView!
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupWebView()
    setupActivityIndicator()
    loadUrl()
  }
  
  private func setupWebView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view.addSubview(webView)
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func setupActivityIndicator() {
    view.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  private func loadUrl() {
    guard let urlString = urlString, let url = URL(string: urlString) else {
      return
    }
    let request = URLRequest(url: url)
    webView.load(request)
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    activityIndicator.startAnimating()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    activityIndicator.stopAnimating()
  }
}
