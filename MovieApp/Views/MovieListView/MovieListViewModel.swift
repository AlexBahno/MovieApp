//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 01.02.2024.
//

import Foundation

final class MovieListViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[MovieCellViewModel]> = Observable([])
    var dataSource: MovieResponse?
    private let manager = CoreManager.shared
    
    func numberOfRows(in section: Int) -> Int {
        dataSource?.results?.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        NetworkService.shared.getTrendingMovies { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        cellDataSource.value = dataSource?.results?.compactMap({ MovieCellViewModel(movie: $0) })
    }
    
    func retrieveMovie(id: Int) -> Movie? {
        guard let movie = dataSource?.results?.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
    func saveMovie(indexPath: IndexPath) -> Bool {
        if let dataSource = dataSource,
           !manager.movies.map({ Int($0.id) }).contains(dataSource.results![indexPath.row].id) {
            manager.addNew(favourite: dataSource.results![indexPath.row])
            return true
        }
        return false
    }
}
