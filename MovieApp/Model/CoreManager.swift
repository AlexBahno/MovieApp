//
//  CoreManager.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import Foundation
import CoreData

class CoreManager {
    static let shared = CoreManager()
    var movies = [FavouriteMovie]()
    
    private init() {
        fetchAllMovies()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouriteMovie")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllMovies() {
        let req = FavouriteMovie.fetchRequest()
        if let movies = try? persistentContainer.viewContext.fetch(req) {
            self.movies = movies
        }
    }
    
    func addNew(favourite movie: Movie) {
        let savedMovie = FavouriteMovie(context: persistentContainer.viewContext)
        savedMovie.id = Int32(movie.id ?? 0)
        savedMovie.title = movie.title ?? "Title"
        savedMovie.releaseDate = movie.releaseDate
        savedMovie.genre = movie.getGenres()
        savedMovie.image = NetworkConstants.imageServerAddress + (movie.posterPath ?? "")
        savedMovie.rating = movie.voteAverage ?? 0
        saveContext()
        fetchAllMovies()
    }
}
