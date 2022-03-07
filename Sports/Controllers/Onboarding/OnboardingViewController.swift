//
//  OnboardingViewController.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingViewControllerDidFinishOnboarding()
}

class OnboardingViewController: UIViewController {

    
    weak var delegate: OnboardingViewControllerDelegate?
    private var nextPressCount = 0
    private var selectedLeagues: [LeagueTableViewModel] = [LeagueTableViewModel]()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        return button
    }()
    
    private let welcomeVC = WelcomeViewController()
    private let sportsPickerVC = SportPickerViewController()
    private let countryPickerVC = CountryPickerViewController()
    private let leaguesPickerVC = LeaguePickerViewController()

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)
        blurredVisualEffect.frame = view.bounds
        view.addSubview(scrollView)
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: scrollView.frame.height)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        addChildren()
        configureConstraints()
        scrollView.isScrollEnabled = false
    }
    
    @objc private func didTapNext() {
        
        nextPressCount += 1

        if scrollView.contentSize.width / scrollView.contentOffset.x > 0 || scrollView.contentSize.width / scrollView.contentOffset.x < 3 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [weak self] in
                self?.scrollView.contentOffset = CGPoint(x: (self?.scrollView.contentOffset.x)! + (self?.scrollView.contentSize.width)! / 4, y: 0)
                self?.nextButton.alpha = 1
            }
        }
  
        
        if nextPressCount > 3 && selectedLeagues.count > 0 {
            
            print("saving")
            UserDefaults.standard.set(true, forKey: "isWelcomed")
            DatabaseManager.shared.downloadLeagues(with: selectedLeagues) { [weak self] result in
                switch result {
                case .success():
                    let alert = UIAlertController(title: "Setup Done", message: "Thank you for letting us know your favourites", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler:{ action in
                        self?.dismiss(animated: true)
                        self?.delegate?.onboardingViewControllerDidFinishOnboarding()
                    })
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        

    }
    
    private func addChildren() {
        addChild(welcomeVC)
        scrollView.addSubview(welcomeVC.view)
        welcomeVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        welcomeVC.didMove(toParent: self)
        welcomeVC.delegate = self
        
        addChild(sportsPickerVC)
        scrollView.addSubview(sportsPickerVC.view)
        sportsPickerVC.view.frame = CGRect(x: view.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        sportsPickerVC.delegate = self
        sportsPickerVC.didMove(toParent: self)
        
        addChild(countryPickerVC)
        scrollView.addSubview(countryPickerVC.view)
        countryPickerVC.view.frame = CGRect(x: view.frame.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        countryPickerVC.delegate = self
        countryPickerVC.didMove(toParent: self)
        
        addChild(leaguesPickerVC)
        scrollView.addSubview(leaguesPickerVC.view)
        leaguesPickerVC.view.frame = CGRect(x: view.frame.width * 3, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        leaguesPickerVC.delegate = self
        leaguesPickerVC.didMove(toParent: self)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
    }

    
    private func configureConstraints() {
        let nextButtonConstraints = [
            nextButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(nextButtonConstraints)
    }
 
    
}


extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.nextButton.alpha =  (self?.scrollView.contentOffset.x)! > 0 ? 1 : 0
        }
    }
}

extension OnboardingViewController: WelcomeViewControllerDelegate, SportPickerViewControllerDelegate, CountryPickerViewControllerDelegate, LeaguePickerViewControllerDelegate {
    func didFinishPickLeageus(_ leagues: [LeagueTableViewModel]) {
        selectedLeagues = leagues
    }
    

    func sportPickerViewControllerDidPickSports(_ controller: SportPickerViewController) {
        leaguesPickerVC.sports = controller.selectedSports
    }
    
    func welcomeViewControllerDidTapStart() {
        didTapNext()
    }
    
    func countryPickerViewControllerDidPickCountries(_ controller: CountryPickerViewController) {
        leaguesPickerVC.countries = controller.selectedCountries
        leaguesPickerVC.prepareTables()
    }
}
