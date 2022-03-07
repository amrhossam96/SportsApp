//
//  LeaguePickerTableViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 25/02/2022.
//

import UIKit

class LeaguePickerTableViewCell: UITableViewCell {

    static let identifier = "LeaguePickerTableViewCell"
    
    private let backgroundUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sportsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Football_%28soccer_ball%29.svg/1200px-Football_%28soccer_ball%29.svg.png") else {
            return UIImageView()
        }
        imageView.sd_setImage(with: url)
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    func configure(with model: LeagueTableViewModel) {
        label.text = model.leagueName
        guard let url = URL(string: model.leagueIcon) else {return}
        sportsImageView.sd_setImage(with: url)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backgroundUIView)
        backgroundUIView.addSubview(sportsImageView)
        backgroundUIView.addSubview(label)
        configureConstraints()
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 25
        backgroundColor = .clear
    }
    
    private func configureConstraints() {
        
        let backgroundUIViewConstraints = [
            backgroundUIView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backgroundUIView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundUIView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let sportsImageViewConstraints = [
            sportsImageView.leadingAnchor.constraint(equalTo: backgroundUIView.leadingAnchor, constant: 20),
            sportsImageView.centerYAnchor.constraint(equalTo: backgroundUIView.centerYAnchor),
            sportsImageView.heightAnchor.constraint(equalToConstant: 50),
            sportsImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: sportsImageView.trailingAnchor, constant: 25),
            label.centerYAnchor.constraint(equalTo: sportsImageView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(backgroundUIViewConstraints)
        NSLayoutConstraint.activate(sportsImageViewConstraints)
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
