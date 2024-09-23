//
//  RatingView.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 19/09/24.
//

import UIKit

class RatingView: UIView {
    
    //MARK: View objects
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var heartImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var groupedPersonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.3.sequence.fill"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var avgVoteCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(horizontalStackView)
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        horizontalStackView.addArrangedSubview(heartImageView)
        horizontalStackView.addArrangedSubview(popularityLabel)
        horizontalStackView.addArrangedSubview(groupedPersonImageView)
        horizontalStackView.addArrangedSubview(avgVoteCountLabel)
    }
    
    func configure(with popularity: Float?, avgVoteCount: Float?) {
        guard let popularity = popularity else { return }
        guard let avgVoteCount = avgVoteCount else { return }
        popularityLabel.text = "\(popularity)"
        avgVoteCountLabel.text = "generic.voted.by".localized() + " \(avgVoteCount)"
    }
}
