//
//  SavedDetailsViewController.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 03.02.2024.
//

import UIKit

class SavedDetailsViewController: UIViewController {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Coordinator
    var coordinator: SavedDetailsCoordinator?
    
    // MARK: ViewModel
    var viewModel: SavedDetailsViewModel
    
    init(viewModel: SavedDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configView()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(genresLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            genresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            genresLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func configView() {
        title = "Saved Movie Details"
        view.backgroundColor = .systemBackground
        
        titleLabel.text = viewModel.movieTitle
        releaseDateLabel.text = viewModel.movieReleaseDate
        genresLabel.text = viewModel.movieGenres
    }
}
