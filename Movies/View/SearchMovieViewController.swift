//
//  ViewController.swift
//  Movies
//
//  Created by Pierpaolo Mariani on 03/06/24.
//

import UIKit
import RxSwift

class SearchMovieViewController: BaseViewController {
    
    //MARK: ViewModel
    private let searchViewModel = SearchMovieViewModel()
    
    //MARK: Data
    private var filteredMovies: [Movie] = []
    
    //MARK: Dsiposable
    private var disposeBag: DisposeBag = DisposeBag()
    
    //MARK: view objects
    private let searchController = UISearchController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.tableViewIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "generic.search.movies".localized())
        subscribeToViewModel()
        setupTableView()
        setupSearchController()
        setupDelegate()
        setupSearchControllerDelegate()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupSearchController() {
        searchController.searchBar.tintColor = .white
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.red
            textField.attributedPlaceholder = NSAttributedString(string: "generic.search.movies".localized(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.tintColor = .white
            textField.backgroundColor = .darkGray
        }
    }
    
    private func setupSearchControllerDelegate() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func subscribeToViewModel() {
        searchViewModel.stateSubject.subscribe(onNext: { [weak self] state in
            switch state {
            case .success(movies: let movie):
                self?.filteredMovies = movie
                self?.tableView.reloadData()
            case .failed(error: let error):
                self?.displayAlertController(error: error, handler: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: Delegates
extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewIdentifier, for: indexPath) as? MovieTableViewCell  else { return UITableViewCell() }
        let movie = filteredMovies[indexPath.row]
        cell.configure(title: movie.title ?? "", poster: movie.poster_path)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.modalPresentationStyle = .formSheet
        let selectedMovie = filteredMovies[indexPath.row]
        movieDetailViewController.onMovieReceived = { movie in
            movieDetailViewController.updateWithMovieInfo(with: movie)
        }
        movieDetailViewController.onMovieReceived?(selectedMovie)
        self.present(movieDetailViewController, animated: true)
    }
}

extension SearchMovieViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchViewModel.searchMovies(query: text)
    }
}



