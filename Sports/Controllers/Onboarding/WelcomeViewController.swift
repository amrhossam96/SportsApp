//
//  WelcomeViewController.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit



protocol WelcomeViewControllerDelegate: AnyObject {
    func welcomeViewControllerDidTapStart()
}

class WelcomeViewController: UIViewController {
    
    
    weak var delegate: WelcomeViewControllerDelegate?

    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Give us
        a chance to personalize your journey.
        """
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("   Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .bold))
        button.tintColor = .white
        button.setImage(image, for: .normal)
        return button
    }()
    

    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(welcomeLabel)
        view.addSubview(blurredVisualEffect)
        blurredVisualEffect.contentView.addSubview(startButton)
        configureConstraints()
        startButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    }
    
    @objc private func didTapStart() {
        delegate?.welcomeViewControllerDidTapStart()
    }
    
    
 
 
    
    
    private func configureConstraints() {
        let welcomeLabelConstraints = [
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -55),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let startButtonConstraints = [
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            startButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 45),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        
        let blurredVisualEffectConstraints = [
            blurredVisualEffect.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            blurredVisualEffect.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),
            blurredVisualEffect.leadingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -20),
            blurredVisualEffect.trailingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: 20),
            blurredVisualEffect.topAnchor.constraint(equalTo: startButton.topAnchor, constant: -10),
            blurredVisualEffect.bottomAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10)
        ]
   
        
        
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        NSLayoutConstraint.activate(startButtonConstraints)
        NSLayoutConstraint.activate(blurredVisualEffectConstraints)

        
    }
    

   
    

}
