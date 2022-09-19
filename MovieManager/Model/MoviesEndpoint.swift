//
//  MoviesEndpoint.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import Foundation

struct Movies: Codable {
    let movies: [MoviesEntity]
    let totalResults, response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}

struct MoviesEntity: Codable {
    var title, year, rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var poster: String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
    }
}
