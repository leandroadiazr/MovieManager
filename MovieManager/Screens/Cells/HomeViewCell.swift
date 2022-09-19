//
//  HomeViewCell.swift
//  MovieManager
//
//  Created by Leandro Diaz on 9/18/22.
//

import UIKit

class HomeViewCell: UITableViewCell {
    static let reuseID = "HomeViewCell"
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var posterImage: Poster = {
        let poster = Poster(frame: .zero)
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func configureMovieCell(movies: MoviesEntity) {
        
        titleLabel.text = movies.title
        detailsLabel.text = movies.year
        ratingsLabel.text =  String(format: "%.1f", Double.random(in: 1.0..<10.0))
        posterImage.downloadImage(from: movies.poster)
    }
    
    private func configure() {
        accessoryType = .disclosureIndicator
        addSubview(titleLabel)
        addSubview(detailsLabel)
        addSubview(ratingsLabel)
        addSubview(posterImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            posterImage.widthAnchor.constraint(equalToConstant: 90),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            detailsLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            ratingsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ratingsLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingsLabel.heightAnchor.constraint(equalToConstant: 40),
            ratingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 1.5)
        ])
        
    }
}
