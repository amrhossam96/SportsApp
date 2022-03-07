//
//  PlayerViewController.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class PlayerViewController: UIViewController {

    private let playerImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private let playerTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    
    private let nationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let biographyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Biogaraphy"
        return label
    }()
    
    private let biographyParagraphLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)
        view.addSubview(scrollView)
        scrollView.addSubview(playerImageView)
        scrollView.addSubview(playerNameLabel)
        scrollView.addSubview(playerTeamLabel)
        scrollView.addSubview(nationalityLabel)
        scrollView.addSubview(biographyTitleLabel)
        scrollView.addSubview(biographyParagraphLabel)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 1.5)

        
        configureConstraints()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurredVisualEffect.frame = view.bounds
        scrollView.frame = view.bounds
        biographyParagraphLabel.sizeToFit()
    }

    
    func configureWith(player: Player) {
        guard let url = URL(string: player.strCutout) else {
            return
        }
        
        playerImageView.sd_setImage(with: url)
        playerNameLabel.text = player.strPlayer
        playerTeamLabel.text = player.strTeam
        nationalityLabel.text = player.strNationality
        biographyParagraphLabel.text = player.strDescriptionEN
    }
    
    private func configureConstraints() {
        let playerImageViewContraints = [
            playerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            playerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 90),
            playerImageView.heightAnchor.constraint(equalToConstant: 150),
            playerImageView.widthAnchor.constraint(equalToConstant: 150)
            
        ]
        
        let playerNameLabelConstraints = [
            playerNameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            playerNameLabel.topAnchor.constraint(equalTo: playerImageView.topAnchor, constant: 10)
        ]
        
        let playerTeamLabelConstraints = [
            playerTeamLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            playerTeamLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 15)
        ]

        let nationalityLabelContraints = [
            nationalityLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            nationalityLabel.topAnchor.constraint(equalTo: playerTeamLabel.bottomAnchor, constant: 15)
        ]
        
        let biographyTitleLabelContraints = [
            biographyTitleLabel.leadingAnchor.constraint(equalTo: playerImageView.leadingAnchor),
            biographyTitleLabel.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 20)
        ]
        
        let biographyParagraphLabelConstraints = [
            biographyParagraphLabel.leadingAnchor.constraint(equalTo: biographyTitleLabel.leadingAnchor),
            biographyParagraphLabel.topAnchor.constraint(equalTo: biographyTitleLabel.bottomAnchor, constant: 20),
            biographyParagraphLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        ]

        NSLayoutConstraint.activate(playerImageViewContraints)
        NSLayoutConstraint.activate(playerNameLabelConstraints)
        NSLayoutConstraint.activate(playerTeamLabelConstraints)
        NSLayoutConstraint.activate(nationalityLabelContraints)
        NSLayoutConstraint.activate(biographyParagraphLabelConstraints)
        NSLayoutConstraint.activate(biographyTitleLabelContraints)
        
    }

}
