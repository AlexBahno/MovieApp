//
//  MovieCellViewModel.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import Foundation
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)

final class MovieCellViewModel {
    var id: Int
    var title: String
    var date: String
    var rating: String
    var imageUrl: String
    
    init(movie: Movie) {
        id = movie.id ?? 0
        title = movie.title ?? "title"
        rating = "\(String(format: "%.1f", movie.voteAverage ?? 0))/10"
        date = movie.releaseDate ?? "release date"
        imageUrl = NetworkConstants.imageServerAddress + (movie.posterPath ?? "")
    }
    
    init(movie: FavouriteMovie) {
        id = Int(movie.id)
        title = movie.title ?? "title"
        rating = "\(String(format: "%.1f", movie.rating))/10"
        date = movie.releaseDate ?? "release date"
        imageUrl = NetworkConstants.imageServerAddress + (movie.image ?? "")
    }
}
