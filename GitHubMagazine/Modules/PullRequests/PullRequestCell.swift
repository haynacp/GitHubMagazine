//
//  PullRequestCell.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import Foundation
import UIKit
import SDWebImage

class PullRequestCell: UITableViewCell {
  static let identifier = "PullRequestCell"
  
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = UIColor(hex: "#3977aa")
    label.numberOfLines = 0
    return label
  }()
  
  private let bodyLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.numberOfLines = 3
    return label
  }()
  
  private let usernameLabel = UILabel()
  private let avatarImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(bodyLabel)
    contentView.addSubview(usernameLabel)
    contentView.addSubview(avatarImageView)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    
    bodyLabel.font = .systemFont(ofSize: 14)
    bodyLabel.textColor = .darkGray
    bodyLabel.numberOfLines = 3
    
    usernameLabel.font = .systemFont(ofSize: 14)
    usernameLabel.textColor = UIColor(hex: "#3977aa")
    
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.layer.cornerRadius = 20
    avatarImageView.clipsToBounds = true
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      avatarImageView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      avatarImageView.widthAnchor.constraint(equalToConstant: 40),
      avatarImageView.heightAnchor.constraint(equalToConstant: 40),
      avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      
      usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
      usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  func configure(with pullRequest: PullRequestsResponse) {
    titleLabel.text = pullRequest.title
    bodyLabel.text = pullRequest.body
    usernameLabel.text = pullRequest.user.login
    
    if let avatarURL = URL(string: pullRequest.user.avatar_url) {
      URLSession.shared.dataTask(with: avatarURL) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          self.avatarImageView.image = UIImage(data: data)
        }
      }.resume()
    }
  }
}
