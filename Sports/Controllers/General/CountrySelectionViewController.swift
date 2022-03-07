//
//  CountrySelectionViewController.swift
//  Sports
//
//  Created by Amr Hossam on 27/02/2022.
//

import UIKit

class CountrySelectionViewController: UIViewController {
    
    private var countries: [CountryTableViewModel] = [CountryTableViewModel]()
    var selectedCountries: [String] = [String]()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = """
                    Choose a country
                    """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 42, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CountriesPickerTableViewCell.self, forCellReuseIdentifier: CountriesPickerTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .clear

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(tableView)
        configureConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        fetchCountries()
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    private func fetchCountries() {
        APICaller.shared.getAllCountres { [weak self] result in
            switch result {
            case .success(let countries):
                
                countries.forEach {
                    self?.countries.append(CountryTableViewModel(countryName: $0.name_en, isSelected: false))
                }
                self?.countries = (self?.countries.sorted(by: {
                    $0.countryName < $1.countryName
                }))!
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureConstraints() {
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width - 30)
        ]
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private let blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        return UIVisualEffectView(effect: blurEffect)
    }()

}


extension CountrySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesPickerTableViewCell.identifier, for: indexPath) as? CountriesPickerTableViewCell else {
            return UITableViewCell()
        }
        let checkmarkImage = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen))
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(checkmarkImage?.size.width)! * 2, height:(checkmarkImage?.size.height)! * 2));
        checkmark.image = checkmarkImage
        
        let circleImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .white))
        let circle  = UIImageView(frame:CGRect(x:0, y:0, width:(circleImage?.size.width)! * 2, height:(circleImage?.size.height)! * 2));
        circle.image = circleImage
        
        cell.accessoryView = countries[indexPath.row].isSelected ? checkmark : circle
        
        cell.configure(with: countries[indexPath.row])
        cell.backgroundColor = .clear
        cell.selectedBackgroundView = blurredVisualEffect

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(countries[indexPath.row].countryName)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
