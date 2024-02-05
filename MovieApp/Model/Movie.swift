//
//  Movie.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let results: [Movie]?
}

// MARK: - Movie
struct Movie: Codable {
    let backdropPath: String?
    let id: Int?
    let genreIDS: [Int]?
    let overview: String?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getGenres() -> String {
        guard let genreIDS = genreIDS else {
            return ""
        }
        var genresLine = ""
        for genreId in genreIDS {
            for genre in genres where genre.1 == genreId {
                genresLine += genre.0 + ", "
            }
        }
        genresLine.removeLast()
        genresLine.removeLast()
        return genresLine
    }
}

var genres: [(String, Int)] = [
    ("Action", 28),
    ("Adventure", 12),
    ("Animation", 16),
    ("Comedy", 35),
    ("Crime", 80),
    ("Documentary", 99),
    ("Drama", 18),
    ("Family", 10751),
    ("Fantasy", 14),
    ("History", 36),
    ("Horror", 27),
    ("Music", 10402),
    ("Mystery", 9648),
    ("Romance", 10749),
    ("Science Fiction", 878),
    ("TV Movie", 10770),
    ("Thriller", 53),
    ("War", 10752),
    ("Western", 3)
]
