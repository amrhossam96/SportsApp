//
//  UpcomingView.swift
//  Sports
//
//  Created by Amr Hossam on 28/02/2022.
//

import UIKit

class UpcomingView: UIView {

    
    private var eventsData: [Event] = [Event]()
    var badges: [String: String]?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UpcomingEventCollectionViewCell.self, forCellWithReuseIdentifier: UpcomingEventCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alignmentRect(forFrame: bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUpcomingView(model: [Event]) {
        eventsData = model
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension UpcomingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventCollectionViewCell.identifier, for: indexPath) as? UpcomingEventCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard var badges = badges else {
            return UICollectionViewCell()
        }
        
        cell.configureItem(event: eventsData[indexPath.row], badges: &badges)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width - 50, height: bounds.height - 100)
    }
    
}
