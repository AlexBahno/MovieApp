//
//  MovieDetailsCoordinator.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import Foundation
import UIKit

final class MovieDetailsCoordinator: ChildCoordinator {
    var viewControllerRef: UIViewController?
    var parent: ParentCoordinator?
    
    var navigationController: UINavigationController
    private var movie: Movie?
    
    init(movie: Movie?, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start(animated: Bool) {
        guard let movie = movie else {
            return
        }
        let movieDetailsVM = MovieDetailsViewModel(movie: movie)
        let movieDetailsVC = MovieDetailsViewController(viewModel: movieDetailsVM)
        viewControllerRef = movieDetailsVC
        movieDetailsVC.coordinator = self
        navigationController.pushViewController(movieDetailsVC, animated: animated)
    }
    
    func coordinatorDidFinish() {
        if let parent = parent as? RootCoordinator {
            parent.childDidFinish(self)
        }
    }
}
