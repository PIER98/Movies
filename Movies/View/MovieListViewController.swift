//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 02/08/24.
//

import UIKit
import RxSwift
import Kingfisher

class MovieListViewController: BaseViewController {
    
    //MARK: ViewModel
    private let movieListViewModel = MovieListViewModel()
    
    //MARK: Data
    private var movies: [Movie] = []
    
    //MARK: Disposable
    private let disposeBag = DisposeBag()
    
    //MARK: View objects
    private lazy var moviesListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.color = .red
        loader.style = .large
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "movie.list.discover".localized())
        setup()
        setupCollectionView()
        movieListViewModel.getMovies()
        subscribeToViewModel()
    }
    
    private func setupCollectionView() {
        moviesListCollectionView.delegate = self
        moviesListCollectionView.dataSource = self
    }
    
    private func setup() {
        view.addSubview(moviesListCollectionView)
        moviesListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        moviesListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviesListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviesListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(loader)
        loader.center = self.view.center
    }
    
    private func showLoader() {
        moviesListCollectionView.isHidden = true
        loader.startAnimating()
    }
    
    private func hideLoader() {
        moviesListCollectionView.isHidden = false
        loader.stopAnimating()
    }
    
    private func subscribeToViewModel() {
        movieListViewModel.stateSubject.subscribe(onNext: {[weak self] state in
            switch state {
            case .loading:
                self?.showLoader()
            case .success(movies: let movies):
                self?.movies = movies
                self?.hideLoader()
                self?.moviesListCollectionView.reloadData()
            case .failed(error: let error):
                self?.hideLoader()
                self?.displayAlertController(error: error, handler: {
                    self?.showLoader()
                    self?.movieListViewModel.getMovies()
                })
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: Delegates 
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        cell.configure(title: movie.original_title ?? "", poster: movie.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.modalPresentationStyle = .formSheet
        let selectedMovie = movies[indexPath.row]
        movieDetailViewController.onMovieReceived = { movie in
            movieDetailViewController.updateWithMovieInfo(with: movie)
        }
        movieDetailViewController.onMovieReceived?(selectedMovie)
        self.present(movieDetailViewController, animated: true)
    }
}
