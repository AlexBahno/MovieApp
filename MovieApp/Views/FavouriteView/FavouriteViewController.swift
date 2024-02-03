//
//  FavouriteView.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 31.01.2024.
//

import Foundation
import UIKit

class FavouriteViewController: UIViewController {
    
    let manager = CoreManager.shared
    
    // MARK: Coordinator
    var coordinator: FavouritesCoordinator?
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
        return table
    }()
    
    private var noMovieLable: UILabel = {
        let label = UILabel()
        label.text = "No Favourites Movie"
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addLongPressGesture()
    }
    
    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                manager.movies[indexPath.row].deleteMovie()
                manager.fetchAllMovies()
                let alertController = UIAlertController(title: "Movie Deleted", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default) { _ in
                    
                }
                alertController.addAction(action)
                self.present(alertController, animated: true)
                tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        
        view.addSubview(tableView)
        view.addSubview(noMovieLable)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            noMovieLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMovieLable.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.fetchAllMovies()
        self.tableView.reloadData()
        if manager.movies.count == 0 {
            noMovieLable.isHidden = false
        } else {
            noMovieLable.isHidden = true
        }
    }
    
}
