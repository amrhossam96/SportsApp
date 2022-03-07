//
//  LeaguePickerViewController.swift
//  Sports
//
//  Created by Amr Hossam on 25/02/2022.
//

import UIKit


protocol LeaguePickerViewControllerDelegate: AnyObject {
    func didFinishPickLeageus(_ leagues: [LeagueTableViewModel])
}


class LeaguePickerViewController: UIViewController {
    
    weak var delegate: LeaguePickerViewControllerDelegate?
    
    private var selectedLeagues: [LeagueTableViewModel] = [LeagueTableViewModel]()
    var data: [String: [LeagueTableViewModel]] = [:]
    
    var countries: [String] = [String]()
    var sports: [String] = [String]()
    
    
    private let label: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 42, weight: .bold)
        label.text = """
                     Now Pick your
                     favourite Leagues
                     """
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(LeaguePickerTableViewCell.self, forCellReuseIdentifier: LeaguePickerTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(tableView)
        configureConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

   
  
    
    private func configureConstraints() {
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width - 30)
        ]
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func prepareTables() {
        data = [:]
        for country in countries {
            for sport in sports {
                APICaller.shared.getLeaguesFor(country: country, for: sport) { [weak self] result in
                    switch result {
                    case .success(let leagues):
                        
                        let doesExist = self?.data.contains(where: { key,_ in
                            key == country
                        })
                        if doesExist! {
                            let viewModels = leagues.compactMap { LeagueTableViewModel(leagueIcon: $0.strBadge, leagueName: $0.strLeague, isSelected: false, leagueID: $0.idLeague) }
                            self?.data[country]?.append(contentsOf: viewModels)
                        } else {
                            let viewModels = leagues.compactMap { LeagueTableViewModel(leagueIcon: $0.strBadge, leagueName: $0.strLeague, isSelected: false, leagueID: $0.idLeague) }
                            self?.data[country] = viewModels
                        }

                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
       
    }
    

    private let blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
}


extension LeaguePickerViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys:[String] = data.keys.compactMap { $0 }
        return data[keys[section]]?.count ?? 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaguePickerTableViewCell.identifier, for: indexPath) as? LeaguePickerTableViewCell else {
            return UITableViewCell()
        }
        let keys:[String] = data.keys.compactMap { $0 }
        let leagues = data[keys[indexPath.section]]
        guard let leagues = leagues else {
            return UITableViewCell()
        }
        let league = leagues[indexPath.row]
        cell.configure(with: LeagueTableViewModel(leagueIcon: league.leagueIcon, leagueName: league.leagueName, isSelected: league.isSelected, leagueID: league.leagueID))
        cell.backgroundColor = .clear
        let checkmarkImage = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen))
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(checkmarkImage?.size.width)! * 2, height:(checkmarkImage?.size.height)! * 2));
        checkmark.image = checkmarkImage
        
        let circleImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .white))
        let circle  = UIImageView(frame:CGRect(x:0, y:0, width:(circleImage?.size.width)! * 2, height:(circleImage?.size.height)! * 2));
        circle.image = circleImage
        
        guard let country = data[keys[indexPath.section]] else {return UITableViewCell()}
        
        cell.accessoryView = country[indexPath.row].isSelected ? checkmark : circle
        cell.selectedBackgroundView = blurredVisualEffect
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .gray
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys:[String] = data.keys.compactMap { $0 }
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let keys:[String] = data.keys.compactMap { $0 }
        if !(data[keys[indexPath.section]]?[indexPath.row].isSelected)! {
            data[keys[indexPath.section]]?[indexPath.row].isSelected = true
            let league = data[keys[indexPath.section]]?[indexPath.row]
            guard let league = league else {return}
            selectedLeagues.append(league)
        } else {
            data[keys[indexPath.section]]?[indexPath.row].isSelected = false
            let index = selectedLeagues.firstIndex { $0.leagueName == data[keys[indexPath.section]]?[indexPath.row].leagueName
            }
            selectedLeagues.remove(at: index!)
        }
        
        delegate?.didFinishPickLeageus(selectedLeagues)
        tableView.reloadData()
    }
}
