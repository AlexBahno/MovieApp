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
    
    func cleanUpZombieCoordinators() {
        /// Since the `MerchCoordinator` could be initialized from only two places we can assume every other instance of it
        /// existing inside the `childCoordinators` belongs to the `GreenViewController` and is safe to be removed.
        
//        if let currentCoordinators = coordinator?.childCoordinators {
//            for item in currentCoordinators {
//                let contains = initCoordinators.contains(where: {$0 === item})
//                if contains == false {
//                    /// Dismissing newly `MerchCoordinator` children coordinators
//                    if let merchCoordinator = item as? MerchCoordinator {
//                        merchCoordinator.dismissMerchScreens()
//                        coordinator?.childDidFinish(merchCoordinator)
//                    }
//
//                    /// Removing the `BlueCoordinator` which was added throught the `GreenViewController`
//                    if let blueCoordinator = item as? BlueCoordinator, let viewController = blueCoordinator.viewControllerRef as? DisposableViewController {
//                        viewController.cleanUp()
//                        blueCoordinator.viewControllerRef?.navigationController?.popViewController(animated: false)
//                        coordinator?.childDidFinish(blueCoordinator)
//                    }
//                }
//            }
//        }
    }


}
