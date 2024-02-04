//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 31.01.2024.
//

import UIKit

class MovieListViewController: UIViewController, Storyboardable {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Coordinator
    var coordinator: MovieListCoordinator?
    
    // MARK: ViewModel
    var viewModel: MovieListViewModel = MovieListViewModel()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLongPressGesture()
        viewModel.getData()
        configView()
        bindViewModel()
    }
    
    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if viewModel.saveMovie(indexPath: indexPath) {
                    let alertController = UIAlertController(title: "Movie Saved", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default) { _ in
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    private func configView() {
        view.backgroundColor = .systemBackground
        title = "Movie List"
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, movies != nil else {
                return
            }
            self.reloadTableView()
        }
    }
}
