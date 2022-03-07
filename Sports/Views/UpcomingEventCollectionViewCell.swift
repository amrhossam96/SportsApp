//
//  UpcomingEventCollectionViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 02/03/2022.
//

import UIKit

class UpcomingEventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UpcomingEventCollectionViewCell"
    
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let awayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        configureGradientBackground()

        containerView.addSubview(homeLabel)
        containerView.addSubview(awayLabel)
        containerView.addSubview(homeImageView)
        containerView.addSubview(awayImageView)
        containerView.addSubview(startLabel)
        configureConstraints()

    }
    
    
    private func configureConstraints() {
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        let homeLabelConstraints = [
            homeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            homeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
            
        ]
        
        let awayLabelConstraints = [
            awayLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            awayLabel.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 30)
        ]
        
        let homeImageViewConstraints = [
            homeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            homeImageView.centerYAnchor.constraint(equalTo: homeLabel.centerYAnchor),
            homeImageView.widthAnchor.constraint(equalToConstant: 50)

        ]
        
        let awayImageViewConstraints = [
            awayImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            awayImageView.centerYAnchor.constraint(equalTo: awayLabel.centerYAnchor),
            awayImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let startLabelConstraints = [
            startLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            startLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(homeLabelConstraints)
        NSLayoutConstraint.activate(awayLabelConstraints)
        NSLayoutConstraint.activate(homeImageViewConstraints)
        NSLayoutConstraint.activate(awayImageViewConstraints)
        NSLayoutConstraint.activate(startLabelConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

    
    private func configureGradientBackground() {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [
            UIColor(red: 50/255, green: 59/255, blue: 227/255, alpha: 1).cgColor,
            UIColor(red: 86/255, green: 17/255, blue: 145/255, alpha: 1).cgColor
        ]
        layer.locations = [ 0.0, 0.8]
        containerView.layer.addSublayer(layer)
    }
    
    func configureItem(event: Event, badges: inout [String : String]) {
        homeLabel.text = event.strHomeTeam
        awayLabel.text = event.strAwayTeam
        guard let homeURLString = badges[event.idHomeTeam],
              let awayURLString = badges[event.idAwayTeam],
              let homeURL = URL(string: homeURLString),
              let awayURL = URL(string: awayURLString)
        else {
            return
        }
        homeImageView.sd_setImage(with: homeURL)
        awayImageView.sd_setImage(with: awayURL)
        startLabel.text = "🕑 Starts at \(event.strTime.dropLast().dropLast().dropLast())"
    }
}
