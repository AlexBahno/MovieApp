//
//  MovieViewCell.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 02.02.2024.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieViewCell: UITableViewCell {

    public static var identifier: String {
        get {
            "MovieViewCell"
        }
    }
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {                
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(movieImage)
        contentView.addSubview(title)
        contentView.addSubview(releaseDate)
        contentView.addSubview(rating)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            movieImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            releaseDate.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            releaseDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            rating.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            rating.bottomAnchor.constraint(equalTo: releaseDate.topAnchor, constant: -5)
        ])
    }
    
    func setupCell(viewModel: MovieCellViewModel) {
        title.text = viewModel.title
        releaseDate.text = "Premier: " + viewModel.date
        rating.text = "Rating: " + viewModel.rating
        guard let image = imageCache.image(withIdentifier: viewModel.imageUrl) else {
            AF.request(viewModel.imageUrl)
                .validate()
                .responseImage { [weak self] response in
                    if response.value != nil {
                        let image = UIImage(data: response.data!)!
                        self?.movieImage.image = image
                        imageCache.add(image, withIdentifier: viewModel.imageUrl)
                    }
                }
            return
        }
        movieImage.image = image
    }
}
