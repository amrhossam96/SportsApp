//
//  EventTableViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 26/02/2022.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    static let identifier = "EventTableViewCell"

    
    
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let awayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let homeTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awayTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dashMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let homeScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let awayScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(homeLabel)
        contentView.addSubview(awayLabel)
        contentView.addSubview(dashMarkLabel)
        contentView.addSubview(homeTeamImageView)
        contentView.addSubview(awayTeamImageView)
        contentView.addSubview(homeScoreLabel)
        contentView.addSubview(awayScoreLabel)
        backgroundColor = .secondarySystemBackground
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let dashMarkLabelConstraints = [
            dashMarkLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dashMarkLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let homeScoreLabelConstraints = [
            homeScoreLabel.trailingAnchor.constraint(equalTo: dashMarkLabel.leadingAnchor),
            homeScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            homeScoreLabel.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        let awayScoreLabelConstraints = [
            awayScoreLabel.leadingAnchor.constraint(equalTo: dashMarkLabel.trailingAnchor),
            awayScoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            awayScoreLabel.widthAnchor.constraint(equalToConstant: 30)

        ]
        
        
       
       let homeTeamImageViewConstraints = [
           homeTeamImageView.trailingAnchor.constraint(equalTo: homeScoreLabel.leadingAnchor, constant: -7),
           homeTeamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
           homeTeamImageView.widthAnchor.constraint(equalToConstant: 35),
           homeTeamImageView.heightAnchor.constraint(equalToConstant: 35)

       ]
       
       let awayTeamImageViewConstraints = [
           awayTeamImageView.leadingAnchor.constraint(equalTo: awayScoreLabel.trailingAnchor, constant: 7),
           awayTeamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
           awayTeamImageView.widthAnchor.constraint(equalToConstant: 35),
           awayTeamImageView.heightAnchor.constraint(equalToConstant: 35)

       ]
        
        let homeLabelConstraints = [
            homeLabel.trailingAnchor.constraint(equalTo: homeTeamImageView.leadingAnchor, constant: -7),
            homeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let awayLabelConstraints = [
            awayLabel.leadingAnchor.constraint(equalTo: awayTeamImageView.trailingAnchor, constant: 7),
            awayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        

        
        
        NSLayoutConstraint.activate(dashMarkLabelConstraints)
        NSLayoutConstraint.activate(homeScoreLabelConstraints)
        NSLayoutConstraint.activate(awayScoreLabelConstraints)
        NSLayoutConstraint.activate(homeTeamImageViewConstraints)
        NSLayoutConstraint.activate(awayTeamImageViewConstraints)
        NSLayoutConstraint.activate(homeLabelConstraints)
        NSLayoutConstraint.activate(awayLabelConstraints)
 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureWith(model: Event, badges: inout [String : String]) {

        homeLabel.text = model.strHomeTeam
        awayLabel.text = model.strAwayTeam
        homeScoreLabel.text = model.intHomeScore
        awayScoreLabel.text = model.intAwayScore

        guard let homeUrlString = badges[model.idHomeTeam],
              let awayUrlString = badges[model.idAwayTeam],
              let homeURL = URL(string: homeUrlString),
              let awayURL = URL(string: awayUrlString) else {
                  return
              }

        homeTeamImageView.sd_setImage(with: homeURL)
        awayTeamImageView.sd_setImage(with: awayURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
