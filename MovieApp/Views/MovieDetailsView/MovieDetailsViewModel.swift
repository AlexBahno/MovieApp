//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import Foundation

final class MovieDetailsViewModel {
    
    var movie: Movie
    
    var movieId: Int
    var movieTitle: String
    var movieDescription: String
    var movieReleaseDate: String
    var movieImage: String

    init(movie: Movie) {
        self.movie = movie
        
        movieId = movie.id ?? 0
        movieTitle = movie.title ?? "Title"
        movieDescription = movie.overview ?? "Description"
        movieReleaseDate = movie.releaseDate ?? "Release Date"
        movieImage = NetworkConstants.imageServerAddress + (movie.backdropPath ?? "")
    }
}
