//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 18/09/24.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    //MARK: Closure
    var onMovieReceived: ((Movie) -> Void)?
    
    //MARK: View objects
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
    }
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        scrollView.addSubview(releaseDateLabel)
        releaseDateLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10).isActive = true
        releaseDateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        
        scrollView.addSubview(overviewTextView)
        overviewTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        overviewTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(ratingView)
        ratingView.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: 10).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }
    
    func updateWithMovieInfo(with detail: Movie) {
        guard let imagePath = URL(string: Constants.imagePath + (detail.poster_path ?? "")) else { return }
        print(imagePath)
        posterImageView.kf.setImage(with: imagePath)
        titleLabel.text = detail.title
        releaseDateLabel.text = detail.release_date
        overviewTextView.text = detail.overview
        ratingView.configure(with: detail.popularity, avgVoteCount: detail.vote_average)
    }
}
