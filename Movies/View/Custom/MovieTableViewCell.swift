//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 22/09/24.
//

import Foundation
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    //MARK: Cell objects
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.tableViewIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .black
        contentView.addSubview(posterImage)
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 50).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func configure(title: String, poster: String?) {
        guard let imagePath = URL(string: Constants.imagePath + (poster ?? "")) else { return }
        titleLabel.text = title
        posterImage.kf.setImage(with: imagePath)
    }
}
