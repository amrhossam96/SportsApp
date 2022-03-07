//
//  SportPickerViewController.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit

protocol SportPickerViewControllerDelegate: AnyObject {
    func sportPickerViewControllerDidPickSports(_ controller: SportPickerViewController)
}

class SportPickerViewController: UIViewController {
    
    weak var delegate: SportPickerViewControllerDelegate?
    var selectedSports: [String] = [String]()
    private var sports: [SportTableViewModel] = [SportTableViewModel]()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = """
                    First up, which
                    sport do you enjoy
                    the most
                    """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OnboardingSportTableViewCell.self, forCellReuseIdentifier: OnboardingSportTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    private let blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(tableView)
        configureConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        fetchSports()

    }

    
    private func fetchSports() {
        APICaller.shared.fetchSportsFromDatabase { [weak self] result in
            switch result {
            case .success(let sports):
                sports.forEach {
                    self?.sports.append(
                        SportTableViewModel(
                            sportName: $0.strSport,
                            isSelected: false, sportIcon: $0.strSportIconGreen))
                }
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
            label.widthAnchor.constraint(equalToConstant: view.bounds.width - 50)
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

}

extension SportPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingSportTableViewCell.identifier, for: indexPath) as? OnboardingSportTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        
        
        let checkmarkImage = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .systemGreen))
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(checkmarkImage?.size.width)! * 2, height:(checkmarkImage?.size.height)! * 2));
        checkmark.image = checkmarkImage
        
        let circleImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(hierarchicalColor: .white))
        let circle  = UIImageView(frame:CGRect(x:0, y:0, width:(circleImage?.size.width)! * 2, height:(circleImage?.size.height)! * 2));
        circle.image = circleImage
        
        cell.accessoryView = sports[indexPath.row].isSelected ? checkmark : circle
        cell.configure(with: sports[indexPath.row])
        cell.selectedBackgroundView = blurredVisualEffect

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if !sports[indexPath.row].isSelected {
            sports[indexPath.row].isSelected = true
            selectedSports.append(sports[indexPath.row].sportName)
        } else {
            sports[indexPath.row].isSelected = false
            selectedSports.remove(at: selectedSports.firstIndex(of: sports[indexPath.row].sportName)!)

        }
        delegate?.sportPickerViewControllerDidPickSports(self)
        tableView.reloadData()

        
    }
    

}
