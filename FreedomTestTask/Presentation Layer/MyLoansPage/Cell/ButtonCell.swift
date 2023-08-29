//
//  ButtonCell.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 29.08.2023.
//

import UIKit

typealias ButtonCellConfigurator = TableCellConfigurator<ButtonCell, String>

final class ButtonCell: UITableViewCell {
    static let didTapButtonCellActionId = "didTapButtonCellActionId"
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.green
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.titleLabel?.font = Font.titleSemibold
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
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
extension ButtonCell: ConfigurableCell {
    func configureCell(data: String) {
        button.setTitle(data, for: .normal)
    }
}

private extension ButtonCell {
    func setup() {
        contentView.backgroundColor = Color.drawerBackgroundColor
        contentView.addSubview(button)
    }
    
    func makeConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defaults.edgeOffset),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defaults.edgeOffset),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    @objc func didTapButton() {
        CellAction.custom(Self.didTapButtonCellActionId).invoke(cell: self)
    }
}
