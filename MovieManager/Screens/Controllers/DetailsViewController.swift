//
//  DetailsViewController.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var tableView: UITableView?
    var movies = [MoviesEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.view.backgroundColor = .systemBlue
    }
    
    private func configureTableView() {
        self.navigationController?.title = "Movie Details"
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.frame = view.bounds
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 200
        tableView?.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.reuseID)
        guard let tableView = tableView else { return }
        view.addSubview(tableView)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.reuseID, for: indexPath) as! DetailsTableViewCell
        let movie = movies[indexPath.row]
        cell.configureMovieCell(movies: movie)
        return cell
    }
}
