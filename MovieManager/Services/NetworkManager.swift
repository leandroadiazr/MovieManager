//
//  NetworkManager.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class NetworkManager {
    let cache = NSCache<NSString, UIImage >()
    static let shared = NetworkManager()
    var stringURL = "https://www.omdbapi.com/?apikey=4674eb1f&s="
    var all = "2022"
    
    // Get Movies
    func getMovies(by: String?, completed: @escaping (Result<Movies, ErrorMessage> ) -> Void) {
        let endPoint = stringURL + (by ?? all)
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidRequest))
                return
            }
            
            guard let result = response as? HTTPURLResponse, result.statusCode == 200 else {
                completed(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidRequest))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy =  .iso8601
                let receivedData = try decoder.decode(Movies.self, from: data)
                completed(.success(receivedData))
            } catch {
                completed(.failure(.invalidRequest))
            }
        }
        dataTask.resume()
    }
}
