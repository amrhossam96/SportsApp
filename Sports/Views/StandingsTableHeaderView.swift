//
//  StandingsTableHeaderView.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class StandingsTableHeaderView: UIView {

    
    private let clubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Club"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let MPLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MP"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let wLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "W"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let dLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "D"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let lLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "L"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    private let goalForLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GF"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let goalAgainstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GA"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let goalDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GD"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PTS"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(clubLabel)
        addSubview(MPLabel)
        addSubview(wLabel)
        addSubview(dLabel)
        addSubview(lLabel)
        addSubview(goalForLabel)
        addSubview(goalAgainstLabel)
        addSubview(goalDifferenceLabel)
        addSubview(pointsLabel)
        configureConstraints()
    }
    
    
    private func configureConstraints() {
        
        let clubLabelConstraints = [
            clubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            clubLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let MPLabelConstraints = [
            MPLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -215),
            MPLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        let wLabelConstraints = [
            wLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 25),
            wLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let dLabelConstraints = [
            dLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 50),
            dLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let lLabelConstraints = [
            lLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 75),
            lLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let goalForLabelConstraints = [
            goalForLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 100),
            goalForLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let goalAgainstLabelConstraints = [
            goalAgainstLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 125),
            goalAgainstLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let goalDifferenceLabelConstraints = [
            goalDifferenceLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 150),
            goalDifferenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let pointsLabelConstraints = [
            pointsLabel.leadingAnchor.constraint(equalTo: MPLabel.leadingAnchor, constant: 185),
            pointsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(clubLabelConstraints)
        NSLayoutConstraint.activate(MPLabelConstraints)
        NSLayoutConstraint.activate(wLabelConstraints)
        NSLayoutConstraint.activate(dLabelConstraints)
        NSLayoutConstraint.activate(lLabelConstraints)
        NSLayoutConstraint.activate(goalForLabelConstraints)
        NSLayoutConstraint.activate(goalAgainstLabelConstraints)
        NSLayoutConstraint.activate(goalDifferenceLabelConstraints)
        NSLayoutConstraint.activate(pointsLabelConstraints)

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
