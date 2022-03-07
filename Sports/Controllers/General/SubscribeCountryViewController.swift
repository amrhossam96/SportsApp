//
//  SubscribeCountryViewController.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class SubscribeCountryViewController: UIViewController {

    private var countries: [Country] = []
    var sport: String?
    private let countriesTable: UITableView = {
       
        let tableView = UITableView()
        tableView.register(CountriesPickerTableViewCell.self, forCellReuseIdentifier: CountriesPickerTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(countriesTable)
        countriesTable.dataSource = self
        countriesTable.delegate = self
        fetchCountries()

    }
    
    
    private func fetchCountries() {
        APICaller.shared.getAllCountres { [weak self] result in
            switch result {
            case  .success(let countries):
                self?.countries = countries.sorted(by: {
                    $0.name_en < $1.name_en
                })
                DispatchQueue.main.async {
                    self?.countriesTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        countriesTable.frame = view.bounds
    }
    
}


extension SubscribeCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesPickerTableViewCell.identifier, for: indexPath) as? CountriesPickerTableViewCell else {
            return UITableViewCell()
        }
        
        let country = countries[indexPath.row]
        cell.configure(with: CountryTableViewModel(countryName: country.name_en, isSelected: false))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let sport = sport else {
            return
        }
        let country = countries[indexPath.row].name_en
        APICaller.shared.getLeaguesFor(country: country, for: sport) { [weak self] result in
            switch result {
            case .success(let leagues):
                DispatchQueue.main.async {
                    let vc = SubscribeLeagueViewController()
                    vc.leagues = leagues.map({ league in
                        LeagueTableViewModel(leagueIcon: league.strBadge, leagueName: league.strLeague, isSelected: false, leagueID: league.idLeague)
                    })
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
    }
}
