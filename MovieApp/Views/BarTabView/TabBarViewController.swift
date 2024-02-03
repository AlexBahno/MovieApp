//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    weak var coordinator: RootCoordinator?
    
    private let movieListCoordinator = MovieListCoordinator(navigationController: UINavigationController())
    private let favouriteCoordinator = FavouritesCoordinator(navigationController: UINavigationController())
    private (set) var initCoordinators = [Coordinator]()

    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        movieListCoordinator.parent = coordinator
        coordinator?.addChild(movieListCoordinator)
        
        favouriteCoordinator.parent = coordinator
        coordinator?.addChild(favouriteCoordinator)
        
        movieListCoordinator.start(animated: false)
        favouriteCoordinator.start(animated: false)
        initCoordinators = coordinator?.childCoordinators ?? []
        
        viewControllers = [movieListCoordinator.navigationController, favouriteCoordinator.navigationController]
    }
}
