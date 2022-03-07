//
//  ViewController.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit


class SportsViewController: UIViewController {
    

    private var selectedCell: SportsCollectionViewCell?
    
    private var sports: [Sport] = [Sport]()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 260)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SportsCollectionViewCell.self, forCellWithReuseIdentifier: SportsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.layer.zPosition = 0

        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchSports()
        title = "Sports"
    }
    

    private func fetchSports() {
        APICaller.shared.fetchSportsFromDatabase { [weak self] result in
            switch result {
            case .success(let sports):
                self?.sports = sports
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }

}

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportsCollectionViewCell.identifier, for: indexPath) as? SportsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: sports[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }
    
    
}

extension SportsViewController: SportsCollectionViewCellDelegate {
    func sportsCollectionViewCellDidTapSubscribeTo(indexPath: IndexPath) {
        let vc = SubscribeCountryViewController()
        vc.title = "Subscribing to \(sports[indexPath.row].strSport)"
        vc.sport = sports[indexPath.row].strSport
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- Transition Delegate Conformance
//extension SportsViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        transition.originFrame = view.frame
//        transition.presenting = true
//        return transition
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.presenting = false
//        return transition
//    }
//}
