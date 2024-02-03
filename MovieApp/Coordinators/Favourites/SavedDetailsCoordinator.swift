//
//  SavedDetailsCoordinator.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import UIKit

final class SavedDetailsCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: RootCoordinator?
    var navigationController: UINavigationController
    
    private var movie: FavouriteMovie

    init(navigationController: UINavigationController, movie: FavouriteMovie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start(animated: Bool) {
        let savedDetailsVM = SavedDetailsViewModel(movie: movie)
        let savedDetailsVC = SavedDetailsViewController(viewModel: savedDetailsVM)
        viewControllerRef = savedDetailsVC
        savedDetailsVC.coordinator = self
        navigationController.pushViewController(savedDetailsVC, animated: animated)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
    
}
