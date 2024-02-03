//
//  SavedDetailsViewModel.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import Foundation

class SavedDetailsViewModel {
    
    var movie: FavouriteMovie
    
    var movieId: Int
    var movieTitle: String
    var movieReleaseDate: String
    var movieGenres: String
    
    init(movie: FavouriteMovie) {
        self.movie = movie
        self.movieId = Int(movie.id)
        self.movieTitle = movie.title ?? "Title"
        self.movieReleaseDate = "Premier: " + (movie.releaseDate ?? "Release date")
        self.movieGenres = "Genres: " + (movie.genre ?? "Genres")
    }
}
