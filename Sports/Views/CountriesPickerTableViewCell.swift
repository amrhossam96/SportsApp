//
//  CountriesPickerTableViewCell.swift
//  Sports
//
//  Created by Amr Hossam on 24/02/2022.
//

import UIKit

class CountriesPickerTableViewCell: UITableViewCell {

    static let identifier = "CountriesPickerTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        configureConstraints()
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 25
        
    }
    
    private func configureConstraints() {
        let labelConstraints = [
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with model: CountryTableViewModel) {
        label.text = model.countryName
    }

}
