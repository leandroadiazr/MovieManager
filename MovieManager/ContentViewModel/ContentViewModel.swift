//
//  ContentViewModel.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import Foundation

public typealias VoidClosure = () -> Void

class ContentViewModel {
    var movies: [MoviesEntity]?
    var moviesFiltered: [MoviesEntity]?
    
    func loadData(completion: @escaping VoidClosure) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getAllMovies { dispatchGroup.leave() }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func getAllMovies(completion: @escaping VoidClosure) {
        let all = "2022"
        NetworkManager.shared.getMovies(by: all) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.movies
            case .failure(let error):
                print(error.rawValue)
            }
        }
        completion()
    }
    
    public func getMoviesMathing(string: String, completion: @escaping VoidClosure) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getMovies(by: string, completion: {
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func getMovies(by: String, completion: @escaping VoidClosure) {
        NetworkManager.shared.getMovies(by: by) { [weak self] result in
            switch result {
            case .success(let response):
                self?.moviesFiltered = response.movies
            case .failure(_):
                break
            }
        }
        completion()
    }
}
