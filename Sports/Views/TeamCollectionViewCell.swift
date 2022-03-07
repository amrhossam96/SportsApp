//
//  TeamCollectionViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 27/02/2022.
//

import UIKit



class TeamCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TeamCollectionViewCell"
    
    private let teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(teamImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        teamImageView.frame = contentView.bounds
    }
    
    func configure(with model: Team) {
        guard let url = URL(string: model.strTeamBadge!) else {return}
        teamImageView.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
