//
//  TableStandingTableViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 02/03/2022.
//

import UIKit

class TableStandingTableViewCell: UITableViewCell {

    static let identifier = "TableStandingTableViewCell"
    
    
    private let teamBadgeImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)

        return label
    }()
    
    private let matchesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let drawLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalForLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalAgainstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalDifferenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(rankingLabel)
        contentView.addSubview(teamBadgeImageView)
        contentView.addSubview(matchesPlayedLabel)
        contentView.addSubview(wonLabel)
        contentView.addSubview(drawLabel)
        contentView.addSubview(lostLabel)
        contentView.addSubview(goalForLabel)
        contentView.addSubview(goalAgainstLabel)
        contentView.addSubview(goalDifferenceLabel)
        contentView.addSubview(pointsLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func configure(with model: TableStanding, badges: inout [String: String]) {
        teamNameLabel.text = model.strTeam
        rankingLabel.text = model.intRank
        
        guard let teamURLString = badges[model.idTeam],
              let teamURL = URL(string: teamURLString) else {
            return
        }
        teamBadgeImageView.sd_setImage(with: teamURL)
        matchesPlayedLabel.text = model.intPlayed
        wonLabel.text = model.intWin
        drawLabel.text = model.intDraw
        lostLabel.text = model.intLoss
        goalForLabel.text = model.intGoalsFor
        goalAgainstLabel.text = model.intGoalsAgainst
        goalDifferenceLabel.text = model.intGoalDifference
        pointsLabel.text = model.intPoints
    }
    
    private func configureConstraints() {
        
        let rankingLabelConstraints = [
            rankingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let teamBadgeImageViewConstriants = [
            teamBadgeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            teamBadgeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamBadgeImageView.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        let teamNameLabelConstraints = [
            teamNameLabel.leadingAnchor.constraint(equalTo: teamBadgeImageView.trailingAnchor, constant: 15),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let matchesPlayedLabelConstraints = [
            matchesPlayedLabel.leadingAnchor.constraint(equalTo: teamBadgeImageView.trailingAnchor, constant: 110),
            matchesPlayedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let wonLabelConstraints = [
            wonLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 25),
            wonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let drawLabelConstraints = [
            drawLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 50),
            drawLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let lostLabelConstraints = [
            lostLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 75),
            lostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let goalForLabelConstraints = [
            goalForLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 100),
            goalForLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let goalAgainstLabelConstraints = [
            goalAgainstLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 125),
            goalAgainstLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let goalDifferenceLabelConstraints = [
            goalDifferenceLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 155),
            goalDifferenceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]

        let pointsLabelConstraints = [
            pointsLabel.leadingAnchor.constraint(equalTo: matchesPlayedLabel.leadingAnchor, constant: 185),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(rankingLabelConstraints)
        NSLayoutConstraint.activate(teamBadgeImageViewConstriants)
        NSLayoutConstraint.activate(teamNameLabelConstraints)
        NSLayoutConstraint.activate(matchesPlayedLabelConstraints)
        NSLayoutConstraint.activate(wonLabelConstraints)
        NSLayoutConstraint.activate(drawLabelConstraints)
        NSLayoutConstraint.activate(lostLabelConstraints)
        NSLayoutConstraint.activate(goalForLabelConstraints)
        NSLayoutConstraint.activate(goalAgainstLabelConstraints)
        NSLayoutConstraint.activate(goalDifferenceLabelConstraints)
        NSLayoutConstraint.activate(pointsLabelConstraints)

    }
    

}
