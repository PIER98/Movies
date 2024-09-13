//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 02/08/24.
//

import UIKit
import RxSwift

class MovieListViewController: UIViewController {
    
    //MARK: ViewModel
    private let movieListViewModel = MovieListViewModel()
    
    //MARK: Data
    private var movies: [Movie] = []
    
    //MARK: Disposable
    private let disposeBag = DisposeBag()
    
    //MARK: View objects
    private let moviesListCollectionView: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
        setupCollectionView()
        movieListViewModel.getMovies()
        subscribeToViewModel()
    }
    
    private func setupNavigationBar() {
        self.title = "Discover Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = titleColor
    }
    
    private func setupCollectionView() {
        moviesListCollectionView.delegate = self
        moviesListCollectionView.dataSource = self
    }
    
    private func setup() {
        view.backgroundColor = .black
        view.addSubview(moviesListCollectionView)
        moviesListCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        moviesListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviesListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviesListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func subscribeToViewModel() {
        movieListViewModel.movieSubject.subscribe {[weak self] movies in
            self?.movies = movies
            self?.moviesListCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        cell.configure(title: movie.title, poster: UIImage(systemName: "house.fill")!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
    }
}
