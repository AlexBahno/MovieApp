//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 31.01.2024.
//

import UIKit

class RootCoordinator: NSObject, ParentCoordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var baseTabBarController: TabBarViewController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        baseTabBarController = TabBarViewController(coordinator: self)
        baseTabBarController.coordinator = self
        navigationController.pushViewController(baseTabBarController, animated: animated)
    }
}

extension RootCoordinator {
    func savedMovieDetails(movie: FavouriteMovie, navigationController: UINavigationController, animated: Bool) {
        let savedMovieDetailsCoordiantor = SavedDetailsCoordinator(navigationController: navigationController, movie: movie)
        savedMovieDetailsCoordiantor.parent = self
        addChild(savedMovieDetailsCoordiantor)
        savedMovieDetailsCoordiantor.start(animated: animated)
    }
    
    func movieDetails(movie: Movie, navigationController: UINavigationController, animated: Bool) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(movie: movie, navigationController: navigationController)
        movieDetailsCoordinator.parent = self
        addChild(movieDetailsCoordinator)
        movieDetailsCoordinator.start(animated: animated)
    }
}
