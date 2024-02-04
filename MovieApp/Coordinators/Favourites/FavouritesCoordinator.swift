//
//  FavouritesCoordinator.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import Foundation
import UIKit

final class FavouritesCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: RootCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let favouriteVM = FavouriteViewModel()
        let favouritesVC = FavouriteViewController(viewModel: favouriteVM)
        viewControllerRef = favouritesVC
        favouritesVC.coordinator = self
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        navigationController.pushViewController(favouritesVC, animated: animated)
    }
    
    func savedMovieDetails(_ movie: FavouriteMovie) {
        parent?.savedMovieDetails(movie: movie, navigationController: navigationController, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
}
