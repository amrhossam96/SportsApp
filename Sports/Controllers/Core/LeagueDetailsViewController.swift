//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by Amr Hossam on 27/02/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    var teams: [Team]?
    var events: [Event] = []
    var league: String?
    var standings: [TableStanding] = []
    var teamsBadges: [String: String] = [:]
    private var header: LeagueDetailHeaderView?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
        tableView.register(TableStandingTableViewCell.self, forCellReuseIdentifier: TableStandingTableViewCell.identifier)
        return tableView
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(tableView)
        header = LeagueDetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 570))
        header?.delegate = self
        tableView.tableHeaderView = header
        tableView.delegate = self
        tableView.dataSource = self
        guard let teams = teams else {
            return
        }
        
        for team in teams {
            teamsBadges[team.idTeam!] = team.strTeamBadge
        }
        guard let header = header else {
            return
        }
        
        header.configureHeader(with: teams, badges: &teamsBadges)
        fetchEvents()
        fetchUpcomingEvents()
        fetchLeagueTable()
    }
    
    
    private func fetchLeagueTable() {
        guard let league = league else {
            return
        }

        APICaller.shared.getStadingsForLeagureWith(id: league) { [weak self] result in
            switch result {
            case .success(let standings):
                self?.standings = standings
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func fetchUpcomingEvents() {
        APICaller.shared.getUpcomingMatchForLeagueWith(id: league!) { [weak self] result in
            switch result {
            case .success(let events):
                self?.header?.upcomingView.configureUpcomingView(model: events)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchEvents() {
        guard let league = league else {
            return
        }
        
        APICaller.shared.fetchEventsFor(leagueID: league) { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events.sorted(by: { event1, event2 in
                    let deFormatter = DateFormatter()
                    deFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    guard let startTime1 = deFormatter.date(from: "\(event1.dateEvent) \(event1.strTime)"),
                          let startTime2 = deFormatter.date(from: "\(event2.dateEvent) \(event1.strTime)") else {
                              return true
                          }

                    return startTime1.timeIntervalSince1970 > startTime2.timeIntervalSince1970
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return standings.count > 16 ? 17 : standings.count
        } else {
            return events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableStandingTableViewCell.identifier, for: indexPath) as? TableStandingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: standings[indexPath.row], badges: &teamsBadges)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {
                return UITableViewCell()
            }
            cell.configureWith(model: events[indexPath.row], badges: &teamsBadges)

            return cell
        default:
            return UITableViewCell()
        }
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 120
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "Recent Matches"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension LeagueDetailsViewController: LeagueDetailHeaderViewDelegate {
    func leagueDetailHeaderViewDidTapTeam(_ team: Team, squad: [String]) {
        
        let teamsVC = TeamViewController()
        teamsVC.configure(with: team, squad: squad)
        let navController = UINavigationController(rootViewController: teamsVC)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}
