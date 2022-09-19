//
//  HomeViewController.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tableView: UITableView?
    var searchBar: UISearchController?
    var action: VoidClosure?
    var isFiltering: Bool = false
    let networkManger = NetworkManager.shared
    
    var viewModel: ContentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    private func configure() {
        configureSearch()
        configureTableView()
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = addBtn
    }
    
    func getData() {
        self.viewModel = ContentViewModel()
        self.viewModel?.loadData(completion: {})
    }
    
    func configureNavigationController(with color: UIColor? = .systemBlue) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func configureSearch() {
        searchBar = UISearchController(searchResultsController: nil)
        searchBar?.obscuresBackgroundDuringPresentation = true
        searchBar?.searchBar.placeholder                = "Search..."
        searchBar?.searchResultsUpdater                 = self
        searchBar?.searchBar.returnKeyType              = .go
        searchBar?.delegate                             = self
        searchBar?.searchBar.delegate                   = self
        searchBar?.searchBar.searchTextField.backgroundColor = .white
        searchBar?.searchBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling  = false
        navigationItem.searchController             = searchBar
    }
    
    @objc private func addToFavorites() {
        self.showCustomAlert(title: "Coming soon!", message: "This feature its coming soon... stay tunned", CtaTitle: "Okay", action: nil)
    }
    
    private func configureTableView() {
        tableView                       = UITableView(frame: .zero, style: .plain)
        tableView?.frame                = view.bounds
        tableView?.delegate             = self
        tableView?.dataSource           = self
        tableView?.rowHeight            = 120
        tableView?.backgroundColor = .clear
        tableView?.removeEmptyCells()
        tableView?.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.reuseID)
        guard let tableView = tableView else {return }
        view.addSubview(tableView)
    }
}


//MARK: - Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel?.moviesFiltered?.count ?? 0 > 0 {
            guard let filtered = self.viewModel?.moviesFiltered?.count else { return 0 }
            return filtered
        }
        return self.viewModel?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseID, for: indexPath) as! HomeViewCell
        
        if isFiltering {
            if self.viewModel?.moviesFiltered?.count ?? 0 > 0 {
                guard let movies = self.viewModel?.moviesFiltered else { return UITableViewCell() }
                let movie = movies[indexPath.item]
                cell.configureMovieCell(movies: movie)
            }
        } else {
            guard let movies = self.viewModel?.movies else { return UITableViewCell() }
            let movie = movies[indexPath.row]
            cell.configureMovieCell(movies: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.viewModel?.moviesFiltered?.count ?? 0 > 0 {
            guard let movies = self.viewModel?.moviesFiltered else { return }
            let movie = movies[indexPath.row]
            let detailsVC = DetailsViewController()
            detailsVC.movies.append(movie)
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        } else {
            guard let movies = self.viewModel?.movies else { return }
            let movie = movies[indexPath.row]
            let detailsVC = DetailsViewController()
            detailsVC.movies.append(movie)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}


//MARK: - SEARCH
extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate  {
    func updateSearchResults(for searchController: UISearchController) {
        isFiltering = true
        guard let movies = self.viewModel?.movies else { return }
        guard let string = searchController.searchBar.text, !string.isEmpty else { return }
        self.viewModel?.moviesFiltered = movies.matching(string)
        self.showCustomLoadingView()
        self.networkManger.getMovies(by: string) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.viewModel?.moviesFiltered = response.movies
                if response.movies.count == 0 {
                    guard let filtered = self.viewModel?.moviesFiltered, filtered.count > 0 else {
                        self.showCustomAlert(title: "Movie not found", message: "Please try again!", CtaTitle: "Okay", action: {
                            self.clearTextField()
                        })
                        return
                    }
                }
                self.reloadData()
            case .failure(_):
                break
            }
        }
        self.reloadData()
    }
    
    private func reloadData() {
        self.dismissLoadingView()
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func clearTextField() {
        self.searchBar?.searchBar.searchTextField.text = ""
        self.viewModel?.moviesFiltered = nil
        self.tableView?.reloadData()
        isFiltering = false
    }
    
    func searchFunctionality() {
        let search                                  = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = true
        search.searchBar.placeholder                = "Search..."
        search.searchResultsUpdater                 = self
        search.searchBar.returnKeyType              = .go
        search.delegate                             = self
        search.searchBar.delegate                   = self
        navigationItem.hidesSearchBarWhenScrolling  = true
        navigationItem.searchController             = search
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.showsSearchResultsController = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.moviesFiltered = nil
        self.reloadData()
    }
}
