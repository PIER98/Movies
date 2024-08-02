//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 02/08/24.
//

import UIKit

class MovieListViewController: UIViewController{
    
    //MARK: View objects
    private let moviesListCollectionView: UICollectionView = {
       let collectionView = UICollectionView()
       return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        moviesListCollectionView.delegate = self
        moviesListCollectionView.dataSource = self
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
