//
//  LeftRightTextCell.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 29.08.2023.
//

import UIKit

struct LeftRightTextRowModel {
    let leftText: String
    var rightText: String?
    var rightTextAttributed: NSAttributedString?
}

typealias LeftRightTextCellConfigurator = TableCellConfigurator<LeftRightTextCell, [LeftRightTextRowModel]>

final class LeftRightTextCell: UITableViewCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(stackView)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
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
extension LeftRightTextCell: ConfigurableCell {
    func configureCell(data: [LeftRightTextRowModel]) {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        data.forEach {
            let leftTextLabel = UILabel()
            leftTextLabel.font = Font.captionMedium
            leftTextLabel.text = $0.leftText
            leftTextLabel.textAlignment = .left
            
            let rightTextLabel = UILabel()
            rightTextLabel.font = Font.captionMedium
            if let rightText = $0.rightText {
                rightTextLabel.text = rightText
            }
            if let rightTextAttributed = $0.rightTextAttributed {
                rightTextLabel.attributedText = rightTextAttributed
            }
            rightTextLabel.textAlignment = .right
            
            let rowStackView = UIStackView(arrangedSubviews: [leftTextLabel, rightTextLabel])
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillProportionally
            
            stackView.addArrangedSubview(rowStackView)
        }
    }
}

private extension LeftRightTextCell {
    func setup() {
        contentView.backgroundColor = Color.drawerBackgroundColor
        contentView.addSubview(containerView)
    }
    
    func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Defaults.edgeOffset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Defaults.edgeOffset),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defaults.edgeOffset),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defaults.edgeOffset),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Defaults.edgeOffset),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Defaults.edgeOffset),
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Defaults.edgeOffset),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Defaults.edgeOffset)
        ])
    }
}
