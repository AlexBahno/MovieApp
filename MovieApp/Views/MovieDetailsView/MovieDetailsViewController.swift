//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: Coordinator
    var coordinator: MovieDetailsCoordinator?
    
    // MARK: ViewModel
    var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
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
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        view.addSubview(movieDescription)
        view.addSubview(releaseDate)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -20),
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            releaseDate.topAnchor.constraint(equalTo: movieDescription.bottomAnchor, constant: 10),
            releaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func configView() {
        title = "Movie Details"
        view.backgroundColor = .systemBackground
        movieTitle.text = viewModel.movieTitle
        movieDescription.text = viewModel.movieDescription
        releaseDate.text = "Release Date: " + viewModel.movieReleaseDate
        guard let image = imageCache.image(withIdentifier: viewModel.movieImage) else {
            AF.request(viewModel.movieImage)
                .validate()
                .responseImage { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    if response.value != nil {
                        let image = UIImage(data: response.data!)!
                        self.movieImage.image = image
                        imageCache.add(image, withIdentifier: self.viewModel.movieImage)
                    }
                }
            return
        }
        movieImage.image = image
    }
}
