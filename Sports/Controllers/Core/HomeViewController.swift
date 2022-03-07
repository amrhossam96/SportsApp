//
//  HomeViewController.swift
//  Sports
//
//  Created by Amr Hossam on 26/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    
    private var leagues: [LeagueEntity] = []
    
    private var events: [[Event]] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LeaguePickerTableViewCell.self, forCellReuseIdentifier: LeaguePickerTableViewCell.identifier)
        return table
    }()
    
    private func fetchLeagues() {
        DatabaseManager.shared.fetchingLeaguesFromDataBase { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.leagues = leagues
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        fetchLeagues()
        navigationItem.title = "Favourite Leagues"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLeagues()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchLeagues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let checked = UserDefaults.standard.bool(forKey: "isWelcomed")
        if !checked {
            let vc = OnboardingViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaguePickerTableViewCell.identifier, for: indexPath) as? LeaguePickerTableViewCell else {
            return UITableViewCell()
        }
        let model = leagues[indexPath.row]
        cell.configure(with: LeagueTableViewModel(leagueIcon: model.leagueIcon!, leagueName: model.leagueName!, isSelected: false, leagueID: model.leagueID!))
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DatabaseManager.shared.deleteTitleWith(model: leagues[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.leagues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(leagues[indexPath.row].leagueName!)
        APICaller.shared.fetchTeamsFor(league: leagues[indexPath.row].leagueName!) { [weak self] result in
            switch result {
            case .success(let teams):
                DispatchQueue.main.async {
                    let vc = LeagueDetailsViewController()
                    vc.teams = teams
                    vc.league = self?.leagues[indexPath.row].leagueID
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


extension HomeViewController: OnboardingViewControllerDelegate {
    func onboardingViewControllerDidFinishOnboarding() {
        fetchLeagues()
    }
}
