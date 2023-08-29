//
//  LoanCell.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 28.08.2023.
//

import UIKit

struct LoanCellModel {
    let leftIcon: UIImage
    let title: String
    let isCheckMarkHidden: Bool
    let amountAttributedText: NSAttributedString
    let totalTrackAmount: Int
    let passedTrackAmount: Int
    let bottomLeftText: String
    let bottomRightText: String
    let backgroundColor: UIColor
    var sectionIndex: Int?
    var index: Int?
}

typealias LoanCellConfigurator = TableCellConfigurator<LoanCell, LoanCellModel>

final class LoanCell: UITableViewCell {
    private let leftIcon = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitleSemibold
        return label
    }()
    private let checkMarkIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.checkMark
        return imageView
    }()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, checkMarkIcon])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitleSemibold
        return label
    }()
    private let trackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layer.cornerRadius = 2
        stackView.layer.masksToBounds = true
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    private let bottomLeftLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bodyTextRegular
        label.textColor = Color.textGray
        return label
    }()
    private let bottomRightLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bodyTextRegular
        label.textColor = Color.textGray
        return label
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.add(subviews: leftIcon, titleStackView, amountLabel, trackStackView, bottomLeftLabel, bottomRightLabel)
        view.backgroundColor = .white
        view.layer.cornerRadius = Defaults.edgeOffset
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
extension LoanCell: ConfigurableCell {
    func configureCell(data: LoanCellModel) {
        leftIcon.image = data.leftIcon
        titleLabel.text = data.title
        checkMarkIcon.isHidden = data.isCheckMarkHidden
        amountLabel.attributedText = data.amountAttributedText
        setupTrack(totalTrackAmount: data.totalTrackAmount, passedTrackAmount: data.passedTrackAmount)
        bottomLeftLabel.text = data.bottomLeftText
        bottomRightLabel.text = data.bottomRightText
        contentView.backgroundColor = data.backgroundColor
    }
}

private extension LoanCell {
    func setup() {
        contentView.addSubview(containerView)
    }
    
    func setupTrack(totalTrackAmount: Int, passedTrackAmount: Int) {
        let subviewsCount = trackStackView.arrangedSubviews.count
        
        if subviewsCount < totalTrackAmount {
            for _ in 0 ..< totalTrackAmount - subviewsCount {
                trackStackView.addArrangedSubview(UIView())
            }
        } else if subviewsCount > totalTrackAmount {
            while trackStackView.arrangedSubviews.count > totalTrackAmount {
                guard let trackView = trackStackView.arrangedSubviews.first else { break }
                trackStackView.removeArrangedSubview(trackView)
            }
        }
        
        for (index, view) in trackStackView.arrangedSubviews.enumerated() {
            view.backgroundColor = index < passedTrackAmount ? Color.green : Color.backgroundColor
        }
    }
    
    // MARK: - Constraints
    func makeConstraints() {
        makeContainerViewConstraints()
        makeLeftIconConstraints()
        makeTitleStackViewConstraints()
        makeAmountLabelConstraints()
        makeTrackStackViewConstraints()
        makeBottomLeftLabelConstraint()
        makeBottomRightLabelConstraint()
    }
    
    func makeContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Defaults.edgeOffset),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Defaults.edgeOffset)
        ])
    }
    
    func makeLeftIconConstraints() {
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Defaults.edgeOffset),
            leftIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Defaults.edgeOffset),
            leftIcon.widthAnchor.constraint(equalToConstant: 32),
            leftIcon.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func makeCheckMarkIconConstraints() {
        checkMarkIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkIcon.widthAnchor.constraint(equalToConstant: 16),
            checkMarkIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func makeTitleStackViewConstraints() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.leftAnchor.constraint(equalTo: leftIcon.rightAnchor, constant: 12),
            titleStackView.centerYAnchor.constraint(equalTo: leftIcon.centerYAnchor)
        ])
    }
    
    func makeAmountLabelConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Defaults.edgeOffset),
            amountLabel.centerYAnchor.constraint(equalTo: leftIcon.centerYAnchor)
        ])
    }
    
    func makeTrackStackViewConstraints() {
        trackStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackStackView.leftAnchor.constraint(equalTo: leftIcon.leftAnchor),
            trackStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Defaults.edgeOffset),
            trackStackView.topAnchor.constraint(equalTo: leftIcon.bottomAnchor, constant: Defaults.edgeOffset),
            trackStackView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func makeBottomLeftLabelConstraint() {
        bottomLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLeftLabel.leftAnchor.constraint(equalTo: leftIcon.leftAnchor),
            bottomLeftLabel.topAnchor.constraint(equalTo: trackStackView.bottomAnchor, constant: 8),
            bottomLeftLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Defaults.edgeOffset)
        ])
    }
    
    func makeBottomRightLabelConstraint() {
        bottomRightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomRightLabel.rightAnchor.constraint(equalTo: amountLabel.rightAnchor),
            bottomRightLabel.bottomAnchor.constraint(equalTo: bottomLeftLabel.bottomAnchor)
        ])
    }
}
