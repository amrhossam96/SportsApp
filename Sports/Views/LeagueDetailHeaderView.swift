//
//  LeagueDetailHeaderView.swift
//  Sports
//
//  Created by Amr Hossam on 27/02/2022.
//

import UIKit

protocol LeagueDetailHeaderViewDelegate: AnyObject {
    func leagueDetailHeaderViewDidTapTeam(_ team: Team, squad: [String])
}

class LeagueDetailHeaderView: UIView {
    
    weak var delegate: LeagueDetailHeaderViewDelegate?
    private var teams: [Team] = []
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Teams"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private let teamsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let fixturesLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming Matches"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    let upcomingView: UpcomingView = {
        let view = UpcomingView()
        return view
    }()
    
    let standingsTableHeaderView: StandingsTableHeaderView = {
        let view = StandingsTableHeaderView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(teamsCollectionView)
        addSubview(sectionLabel)
        addSubview(fixturesLabel)
        addSubview(upcomingView)
        addSubview(standingsTableHeaderView)
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        teamsCollectionView.showsHorizontalScrollIndicator = false
        sectionLabel.frame = CGRect(x: 10, y: 0, width: bounds.width - 10, height: 50)
        teamsCollectionView.frame = CGRect(x: 0, y: 60, width: bounds.width, height: 120)
        fixturesLabel.frame = CGRect(x: 10, y: 190, width: bounds.width - 10, height: 40)
        upcomingView.frame = CGRect(x: 0, y: 230, width: bounds.width, height: 510 - 200)
        standingsTableHeaderView.frame = CGRect(x: 0, y: 200 + upcomingView.frame.height, width: frame.width, height: 600 - (upcomingView.frame.origin.y + upcomingView.frame.height))
        

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureHeader(with teams: [Team], badges: inout [String: String]) {
        self.teams = teams
        DispatchQueue.main.async { [weak self] in
            self?.teamsCollectionView.reloadData()

        }
        upcomingView.badges = badges
    }

}

extension LeagueDetailHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as? TeamCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: teams[indexPath.row])
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        APICaller.shared.getSquadForTeamWith(id: teams[indexPath.row].idTeam!) { [weak self] result in
            switch result {
            case .success(let squad):
                self?.delegate?.leagueDetailHeaderViewDidTapTeam((self?.teams[indexPath.row])!, squad: squad)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
