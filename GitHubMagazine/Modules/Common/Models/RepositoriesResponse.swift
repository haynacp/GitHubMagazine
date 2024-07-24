//
//  RepositoriesResponse.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation

struct RepositoriesResponse: Codable {
  let items: [Repository]
}

struct Repository: Codable {
  let id: Int
  let name: String
  let full_name: String
  let owner: Owner
  let description: String?
  let stargazers_count: Int
  let forks_count: Int
  let html_url: String
  let pulls_url: String
}

struct Owner: Codable {
  let login: String
  let avatar_url: String
}

struct User: Decodable {
  let login: String
  let avatar_url: String
}
