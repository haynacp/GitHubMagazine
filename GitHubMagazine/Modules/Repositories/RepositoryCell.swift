//
//  RepositoryCell.swift
//  GitHubMagazine
//
//  Created by Hayna Cardoso on 23/07/24.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
  static let identifier = "RepositoryCell"
  
  private let repositoryNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = UIColor(hex: "#3977aa")
    label.numberOfLines = 0
    return label
  }()
  
  private let ownerUsernameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = UIColor(hex: "#3977aa")
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    return label
  }()
  
  private let ownerAvatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 25
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15)
    label.numberOfLines = 0
    return label
  }()
  
  private let starsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = UIColor(hex: "#df9305")
    return label
  }()
  
  private let forksLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = UIColor(hex: "#df9305")
    return label
  }()
  
  private let leftStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 12
    return stackView
  }()
  
  private let rightStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .center
    return stackView
  }()
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 16
    return stackView
  }()
  
  private let infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 12
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    contentView.addSubview(mainStackView)
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    leftStackView.addArrangedSubview(repositoryNameLabel)
    leftStackView.addArrangedSubview(descriptionLabel)
    leftStackView.addArrangedSubview(infoStackView)
    
    infoStackView.addArrangedSubview(forksLabel)
    infoStackView.addArrangedSubview(starsLabel)
    
    rightStackView.addArrangedSubview(ownerAvatarImageView)
    rightStackView.addArrangedSubview(ownerUsernameLabel)
    
    mainStackView.addArrangedSubview(leftStackView)
    mainStackView.addArrangedSubview(rightStackView)
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      
      ownerAvatarImageView.widthAnchor.constraint(equalToConstant: 50),
      ownerAvatarImageView.heightAnchor.constraint(equalToConstant: 50),
      rightStackView.widthAnchor.constraint(equalToConstant: 90),
      
      forksLabel.widthAnchor.constraint(equalToConstant: 80),
      starsLabel.widthAnchor.constraint(equalToConstant: 80)
    ])
  }
  
  func configure(with repository: Repository) {
    repositoryNameLabel.text = repository.name
    ownerUsernameLabel.text = repository.owner.login
    descriptionLabel.text = repository.description
    starsLabel.text = "⭐️ \(repository.stargazers_count)"
    forksLabel.text = "🍴 \(repository.forks_count)"
    
    if let url = URL(string: repository.owner.avatar_url) {
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          self.ownerAvatarImageView.image = UIImage(data: data)
        }
      }.resume()
    }
  }
}
