//
//  FavouriteViewController+TableView.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import UIKit

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.manager.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
            return UITableViewCell()
        }
        let favouriteMovie = viewModel.manager.movies[indexPath.row]
        cell.selectionStyle = .none
        cell.setupCell(viewModel: MovieCellViewModel(movie: favouriteMovie))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.savedMovieDetails(viewModel.manager.movies[indexPath.row])
    }
}
