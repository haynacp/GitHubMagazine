//
//  PullRequest.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation

struct PullRequestsResponse: Codable {
  let title: String
  let body: String?
  let user: User
  let html_url: String
  
  struct User: Codable {
    let login: String
    let avatar_url: String
  }
}
