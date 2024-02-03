//
//  MovieListCoordinator.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import Foundation
import UIKit

final class MovieListCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: RootCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let movieListViewController = MovieListViewController.createObject()
        viewControllerRef = movieListViewController
        movieListViewController.coordinator = self
        movieListViewController.tabBarItem = UITabBarItem(title: "Movie List", image: UIImage(systemName: "film.stack"), selectedImage: nil)
        navigationController.pushViewController(movieListViewController, animated: animated)
    }
    
    func movieDetails(_ movie: Movie) {
        parent?.movieDetails(movie: movie, navigationController: navigationController, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
}
