//
//  SportsCollectionViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit
import SDWebImage


protocol SportsCollectionViewCellDelegate: AnyObject {
    func sportsCollectionViewCellDidTapSubscribeTo(indexPath: IndexPath)
}

class SportsCollectionViewCell: UICollectionViewCell {
    
    
    private var indexPath: IndexPath?
    weak var delegate: SportsCollectionViewCellDelegate?
    static let identifier = "SportsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let sportsThumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Subscribe", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .secondarySystemFill
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.masksToBounds = true
        contentView.addSubview(imageView)
        blurredVisualEffect.contentView.addSubview(label)
        contentView.addSubview(blurredVisualEffect)
        contentView.addSubview(sportsThumbnailImageView)
        contentView.addSubview(subscribeButton)
        contentView.addSubview(detailsLabel)
        configureConstraints()
        
        subscribeButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
    }
    
    
    @objc private func didTapSubscribe() {
        guard let indexPath = indexPath else {
            return
        }

        delegate?.sportsCollectionViewCellDidTapSubscribeTo(indexPath: indexPath)
    }
    
    private func configureConstraints() {
        
        let blurredConstraints = [
            blurredVisualEffect.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurredVisualEffect.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurredVisualEffect.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let sportsThumbnailImageViewConstraints = [
            sportsThumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sportsThumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            sportsThumbnailImageView.widthAnchor.constraint(equalToConstant: 110),
            sportsThumbnailImageView.heightAnchor.constraint(equalToConstant: 90)
        ]
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: sportsThumbnailImageView.trailingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: sportsThumbnailImageView.topAnchor, constant: 5)
        ]
        
        let subscribeButtonConstraints = [
            subscribeButton.leadingAnchor.constraint(equalTo: sportsThumbnailImageView.trailingAnchor, constant: 20),
            subscribeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            subscribeButton.heightAnchor.constraint(equalToConstant: 40),
            subscribeButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let detailsLabelConstraints =  [
            detailsLabel.leadingAnchor.constraint(equalTo: sportsThumbnailImageView.leadingAnchor),
            detailsLabel.topAnchor.constraint(equalTo: sportsThumbnailImageView.bottomAnchor, constant: 10),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(blurredConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(sportsThumbnailImageViewConstraints)
        NSLayoutConstraint.activate(subscribeButtonConstraints)
        NSLayoutConstraint.activate(detailsLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    func configure(with model: Sport, indexPath: IndexPath) {
        imageView.image = UIImage(named: model.strSport)
        label.text = model.strSport
        sportsThumbnailImageView.image = imageView.image
        sportsThumbnailImageView.contentMode = .scaleAspectFill
        detailsLabel.text = model.strSportDescription
        self.indexPath = indexPath
    }
}

