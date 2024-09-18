//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 12/09/24.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: Cell Objects
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addToFavoritesButton)
        
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: addToFavoritesButton.leadingAnchor, constant: -8).isActive = true
        
        addToFavoritesButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        addToFavoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        addToFavoritesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToFavoritesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configure(title:String, poster: String) {
        guard let imagePath = URL(string: Constants.imagePath + poster) else { return }
        titleLabel.text = title
        posterImage.kf.setImage(with: imagePath)
        print(poster)
    }
}
