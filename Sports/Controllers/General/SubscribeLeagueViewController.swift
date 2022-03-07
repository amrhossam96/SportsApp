//
//  SubscribeLeagueViewController.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class SubscribeLeagueViewController: UIViewController {

    var leagues: [LeagueTableViewModel] = []
    var selectedLeagues: [LeagueTableViewModel] = []
    private let leaguesTable: UITableView = {
        let tableView = UITableView()
        tableView.register(LeaguePickerTableViewCell.self, forCellReuseIdentifier: LeaguePickerTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(leaguesTable)
   
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(didTapSave))

    }
    
    
    @objc private func didTapSave() {
        if selectedLeagues.count > 0 {
            DatabaseManager.shared.downloadLeagues(with: selectedLeagues) { [weak self] result in
                switch result {
                case .success():
                    let alert = UIAlertController(title: "League Added", message: "League Added Successfully", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler:{ action in
                        NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                        self?.navigationController?.popToRootViewController(animated: true)
                        
                    })
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Make sure to select at least one league", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leaguesTable.frame = view.bounds
    }
    


}

extension SubscribeLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaguePickerTableViewCell.identifier, for: indexPath) as? LeaguePickerTableViewCell else {
            return UITableViewCell()
        }
        let checkmarkImage = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen))
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(checkmarkImage?.size.width)! * 2, height:(checkmarkImage?.size.height)! * 2));
        checkmark.image = checkmarkImage
        
        let circleImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .white))
        let circle  = UIImageView(frame:CGRect(x:0, y:0, width:(circleImage?.size.width)! * 2, height:(circleImage?.size.height)! * 2));
        circle.image = circleImage
        cell.accessoryView = leagues[indexPath.row].isSelected ? checkmark : circle

        let league = leagues[indexPath.row]
        cell.configure(with: league)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (!leagues[indexPath.row].isSelected) {
            leagues[indexPath.row].isSelected = true
            selectedLeagues.append(leagues[indexPath.row])
        } else {
            leagues[indexPath.row].isSelected = false
            
            let leagueIndex = selectedLeagues.firstIndex {
                $0.leagueName == leagues[indexPath.row].leagueName
            }
            guard let leagueIndex = leagueIndex else {
                return
            }

            selectedLeagues.remove(at: leagueIndex)

        }
        print(selectedLeagues)
        tableView.reloadData()
    }
}
