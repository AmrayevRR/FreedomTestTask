//
//  TitleCell.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit

typealias TitleCellConfigurator = TableCellConfigurator<TitleCell, String>

final class TitleCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitleSemibold
        label.textColor = Color.textGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        makeConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ConfigurableCell
extension TitleCell: ConfigurableCell {
    func configureCell(data: String) {
        titleLabel.text = data
    }
}

private extension TitleCell {
    func setup() {
        contentView.backgroundColor = Color.backgroundColor
        contentView.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defaults.edgeOffset)
        ])
    }
}
