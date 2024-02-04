//
//  FavouriteViewModel.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 04.02.2024.
//

import Foundation

class FavouriteViewModel {
    
    let manager = CoreManager.shared

    func deleteMovie(indexPath: IndexPath) {
        manager.movies[indexPath.row].deleteMovie()
        manager.fetchAllMovies()
    }
}
