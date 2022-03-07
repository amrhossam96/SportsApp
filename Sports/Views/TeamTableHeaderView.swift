//
//  TeamTableHeaderView.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class TeamTableHeaderView: UIView {

    
    private let clubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let foundedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    
    

    
    
    private let stadiumThumb: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let stadiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.text = "Stadium"
        return label
    }()
    
    private let teamImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func configureConstraints() {
        let teamImageViewConstraints = [
            teamImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            teamImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            teamImageView.heightAnchor.constraint(equalToConstant: 150),
            teamImageView.widthAnchor.constraint(equalToConstant: 150)

        ]
        
        let clubLabelConstraints = [
            clubLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 20),
            clubLabel.topAnchor.constraint(equalTo: teamImageView.topAnchor, constant: 10)
        ]

        let foundedAtLabelConstraints = [
            foundedAtLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 20),
            foundedAtLabel.topAnchor.constraint(equalTo: clubLabel.bottomAnchor, constant: 15)
        ]


        let stadiumThumbConstraints = [
            stadiumThumb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stadiumThumb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stadiumThumb.topAnchor.constraint(equalTo: stadiumLabel.bottomAnchor, constant: 20),
            stadiumThumb.heightAnchor.constraint(equalToConstant: 200)
        ]


        let stadiumLabelConstraints = [
            stadiumLabel.leadingAnchor.constraint(equalTo: teamImageView.leadingAnchor, constant: 20),
            stadiumLabel.topAnchor.constraint(equalTo: teamImageView.bottomAnchor, constant: 20)
        ]

        

        NSLayoutConstraint.activate(teamImageViewConstraints)
        NSLayoutConstraint.activate(clubLabelConstraints)
        NSLayoutConstraint.activate(foundedAtLabelConstraints)
        NSLayoutConstraint.activate(stadiumLabelConstraints)
        NSLayoutConstraint.activate(stadiumThumbConstraints)
        

    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(teamImageView)
        addSubview(stadiumLabel)
        addSubview(clubLabel)
        addSubview(foundedAtLabel)
        addSubview(stadiumThumb)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureHeaderView(team: Team) {
        guard let url = URL(string: team.strTeamBadge!) else {return}
        teamImageView.sd_setImage(with: url)
        clubLabel.text = team.strTeam
        foundedAtLabel.text = "Founded at: \(team.intFormedYear!)"
        guard let stadiumURL = URL(string: team.strStadiumThumb ?? "") else {return}
        print("here")
        stadiumThumb.sd_setImage(with: stadiumURL)
    }
}
