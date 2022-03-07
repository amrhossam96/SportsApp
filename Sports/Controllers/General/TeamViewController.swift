//
//  TeamViewController.swift
//  Sports
//
//  Created by Amr Hossam on 03/03/2022.
//

import UIKit

class TeamViewController: UIViewController {
    
    
    private var squadNames: [String] = []
    
    
    private let headerView: TeamTableHeaderView = {
        let headerView = TeamTableHeaderView()
        return headerView
    }()
    
    private let squadTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    private let teamImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    
    private lazy var blurredVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    private let xmarkButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let clubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let foundedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let stadiumThumb: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let stadiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.text = "Stadium"
        return label
    }()
    

    
    private let squadTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Squad"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurredVisualEffect)

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 550)
        squadTable.tableHeaderView = headerView
        view.addSubview(squadTable)
        squadTable.dataSource = self
        squadTable.delegate = self
        view.addSubview(xmarkButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: xmarkButton)
        xmarkButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = .label
        
    }
    
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
    
    
    
    
    func configure(with team: Team, squad model: [String]) {
        headerView.configureHeaderView(team: team)
        squadNames = model
        DispatchQueue.main.async { [weak self] in
            self?.squadTable.reloadData()
        }
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blurredVisualEffect.frame = view.bounds
        squadTable.frame = view.bounds
    }

    
}


extension TeamViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squadNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = squadNames[indexPath.row]
        cell.backgroundColor = .clear
        cell.accessoryType = .detailButton
        cell.tintColor = .label
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        APICaller.shared.getDetailsForPlayer(name: squadNames[indexPath.row]) { [weak self] result in
            switch result {
            case .success(let player):

                DispatchQueue.main.async {
                    let vc = PlayerViewController()
                    vc.configureWith(player: player)
                    self?.navigationController?.pushViewController(vc, animated: true)

                }
            case .failure( _):
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Failed", message: "Player's data couldn't be fetched at the moment. Please try again Later", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }

            }
        }
        
    }
}
