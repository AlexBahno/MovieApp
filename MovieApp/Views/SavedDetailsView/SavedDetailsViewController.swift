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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(releaseDateLabel.snp.bottom).inset(-10)
        }
    }
    
    private func configView() {
        title = "Saved Movie Details"
        view.backgroundColor = .systemBackground
        
        titleLabel.text = viewModel.movieTitle
        releaseDateLabel.text = viewModel.movieReleaseDate
        genresLabel.text = viewModel.movieGenres
    }
}
