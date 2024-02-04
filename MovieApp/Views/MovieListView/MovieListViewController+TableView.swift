//
//  MovieListViewController+TableView.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 31.01.2024.
//

import Foundation
import UIKit

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        registerCells()
    }
    
    func registerCells() {
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
            return UITableViewCell()
        }
        guard let cellViewModel = viewModel.cellDataSource.value?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.cellDataSource.value?[indexPath.row].id,
              let movie = viewModel.retrieveMovie(id: movieId) else {
            return
        }
        coordinator?.movieDetails(movie)
    }
}
