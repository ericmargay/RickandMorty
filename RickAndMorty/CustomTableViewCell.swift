//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Eric Margay on 02/12/23.
//
import UIKit

class CustomTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var speciesLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }

    private func setupLabels() {
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Futura-Bold", size: 40)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        speciesLabel = UILabel()
        speciesLabel.textColor = .white
        speciesLabel.font = UIFont(name: "Futura", size: 30)
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(speciesLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            speciesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
