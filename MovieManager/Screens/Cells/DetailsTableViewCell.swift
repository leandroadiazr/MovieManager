//
//  DetailsTableViewCell.swift
//  CollecTableView
//
//  Created by Leandro Diaz on 12/5/20.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    static let reuseID = "DetailsTableViewCell"
    let titleLabel  = UILabel()
    let detailsLabel = UILabel()
    let released      = UILabel()
    let rated = UILabel()
    let actors = UILabel()
    let plot = UILabel()
    let viewImage   = Poster(frame: .zero)
    
    var movies: MoviesEntity?
    
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
//        guard let movies = movies else { return }
        
        titleLabel.text = "Title: \(movies.title  ?? "")"
        detailsLabel.text = "Year: \( movies.year  ?? "")"
        viewImage.downloadImage(from: movies.poster)
        released.text = "Released: \( movies.released ?? "")"
        rated.text = "Rated: \(movies.rated  ?? "")"
        actors.text = "Actors: \(movies.actors  ?? "")"
        plot.text = "Plot: \(movies.plot  ?? "")"
       
        
    }
    
    private func configure() {
        
        
        
        let labels = [ titleLabel, detailsLabel, released, rated, actors, plot]
        
        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            addSubview(label)
        }
        
        addSubview(viewImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            viewImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            viewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            viewImage.widthAnchor.constraint(equalToConstant: 90),
            viewImage.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            detailsLabel.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            released.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 2),
            released.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: padding),
            released.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            rated.topAnchor.constraint(equalTo: released.bottomAnchor, constant: 2),
            rated.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: padding),
            rated.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            actors.topAnchor.constraint(equalTo: rated.bottomAnchor, constant: 2),
            actors.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: padding),
            actors.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            plot.topAnchor.constraint(equalTo: actors.bottomAnchor, constant: 2),
            plot.leadingAnchor.constraint(equalTo: viewImage.leadingAnchor, constant: padding),
            plot.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            plot.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
