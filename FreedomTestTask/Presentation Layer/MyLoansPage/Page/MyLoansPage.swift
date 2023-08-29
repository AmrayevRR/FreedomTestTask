//
//  ViewController.swift
//  FreedomTestTask
//
//  Created by Ramir Amrayev on 27.08.2023.
//

import UIKit
import UltraDrawerView

final class MyLoansPage: UIViewController {
    private let viewModel = MyLoansViewModel()
    
    // MARK: - Main tableView
    private let tableView = UITableView()
    private lazy var tableDirector = TableDirector(tableView: tableView, items: [])
    private let cellBuilder = MyLoansCellBuilder()
    
    // MARK: - Drawer tableView
    private let drawerTableView = UITableView()
    private lazy var drawerTableDirector = TableDirector(tableView: drawerTableView, items: [])
    private let drawerCellBuilder = LoanDetailsCellBuilder()
    
    private let drawerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitleSemibold
        label.text = "Детали займа"
        return label
    }()
    private lazy var drawerCloseIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.close
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCloseDrawer))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private lazy var drawerView: DrawerView = {
        let headerView = UIView()
        headerView.add(subviews: drawerTitleLabel, drawerCloseIcon)
        headerView.backgroundColor = Color.drawerBackgroundColor
        let drawerView = DrawerView(scrollView: drawerTableView, headerView: headerView)
        drawerView.availableStates = [.dismissed, .middle]
        drawerView.middlePosition = .fromBottom(450)
        drawerView.cornerRadius = 16
        drawerView.content.view.backgroundColor = Color.drawerBackgroundColor
        return drawerView
    }()
    
    private lazy var blurredEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 0.9
        blurredEffectView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCloseDrawer))
        blurredEffectView.addGestureRecognizer(tap)
        return blurredEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        makeConstraints()
        bindActions()
        bindDrawerActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        drawerView.setState(.dismissed, animated: false)
    }
    
    deinit {
        blurredEffectView.removeFromSuperview()
        drawerView.removeFromSuperview()
    }
}

private extension MyLoansPage {
    func setup() {
        view.backgroundColor = Color.backgroundColor
        tableView.backgroundColor = Color.backgroundColor
        title = "Мои займы"
        view.addSubview(tableView)
        navigationController?.view.add(subviews: blurredEffectView, drawerView)
        drawerView.addListener(self)
        buildCells()
        buildDrawerCells(loan: viewModel.myLoans[0].loans[0])
    }
    
    func bindActions() {
        tableDirector.actionProxy
            .on(action: .didSelect) { [weak self] (conf: LoanCellConfigurator, cell) in
                guard
                    let self = self,
                    let sectionIndex = conf.item.sectionIndex,
                    let index = conf.item.index
                else { return }
                self.buildDrawerCells(loan: self.viewModel.myLoans[sectionIndex].loans[index])
                self.drawerView.middlePosition = .fromBottom(self.drawerTableView.contentSize.height + self.drawerView.headerView.frame.height)
                self.blurredEffectView.isHidden = false
                self.drawerView.setState(.middle, animated: true)
            }
    }
    
    func bindDrawerActions() {
        drawerTableDirector.actionProxy
            .on(action: .custom(ButtonCell.didTapButtonCellActionId)) { (_: ButtonCellConfigurator, cell) in
                print("Button cell tapped")
            }
    }
    
    func buildCells() {
        cellBuilder.buildCells(myLoans: viewModel.myLoans)
        tableDirector.reloadTable(with: cellBuilder.configurableCells)
    }
    
    func buildDrawerCells(loan: Loan) {
        drawerCellBuilder.buildCells(loan: loan)
        drawerTableDirector.reloadTable(with: drawerCellBuilder.configurableCells)
    }
    
    @objc func didTapCloseDrawer() {
        blurredEffectView.isHidden = true
        drawerView.setState(.dismissed, animated: true)
    }
}

// MARK: - DrawerViewListener
extension MyLoansPage: DrawerViewListener {
    func drawerView(_ drawerView: UltraDrawerView.DrawerView, willBeginAnimationToState state: UltraDrawerView.DrawerView.State?, source: UltraDrawerView.DrawerOriginChangeSource) {
        if state == .dismissed {
            blurredEffectView.isHidden = true
        }
    }
    
    func drawerView(_ drawerView: UltraDrawerView.DrawerView, willBeginUpdatingOrigin origin: CGFloat, source: UltraDrawerView.DrawerOriginChangeSource) {
    }
    func drawerView(_ drawerView: UltraDrawerView.DrawerView, didUpdateOrigin origin: CGFloat, source: UltraDrawerView.DrawerOriginChangeSource) {
    }
    func drawerView(_ drawerView: UltraDrawerView.DrawerView, didEndUpdatingOrigin origin: CGFloat, source: UltraDrawerView.DrawerOriginChangeSource) {
    }
    func drawerView(_ drawerView: DrawerView, didChangeState state: DrawerView.State?) {
    }
}

// MARK: - Constraints
private extension MyLoansPage {
    func makeConstraints() {
        makeTableViewComstraints()
        makeDrawerViewConstraints()
        makeBlurredEffectViewConstraints()
    }
    
    func makeTableViewComstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func makeDrawerViewConstraints() {
        guard let navControllerView = navigationController?.view else { return }
        drawerView.headerView.removeConstraints(drawerView.headerView.constraints) // because UltraDrawerView assign some constraints under the hood
        drawerCloseIcon.translatesAutoresizingMaskIntoConstraints = false
        drawerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        drawerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            drawerCloseIcon.centerYAnchor.constraint(equalTo: drawerTitleLabel.centerYAnchor),
            drawerCloseIcon.rightAnchor.constraint(equalTo: drawerView.headerView.rightAnchor, constant: -Defaults.edgeOffset),
            drawerCloseIcon.widthAnchor.constraint(equalToConstant: 24),
            drawerCloseIcon.heightAnchor.constraint(equalToConstant: 24),
            drawerCloseIcon.bottomAnchor.constraint(equalTo: drawerView.headerView.bottomAnchor, constant: -8),
            
            drawerTitleLabel.topAnchor.constraint(equalTo: drawerView.headerView.topAnchor, constant: Defaults.edgeOffset),
            drawerTitleLabel.leftAnchor.constraint(equalTo: drawerView.headerView.leftAnchor, constant: Defaults.edgeOffset),
            
            drawerView.topAnchor.constraint(equalTo: navControllerView.topAnchor),
            drawerView.bottomAnchor.constraint(equalTo: navControllerView.bottomAnchor),
            drawerView.leftAnchor.constraint(equalTo: navControllerView.leftAnchor),
            drawerView.rightAnchor.constraint(equalTo: navControllerView.rightAnchor)
        ])
    }
    
    func makeBlurredEffectViewConstraints() {
        guard let navControllerView = navigationController?.view else { return }
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurredEffectView.topAnchor.constraint(equalTo: navControllerView.topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: navControllerView.bottomAnchor),
            blurredEffectView.leftAnchor.constraint(equalTo: navControllerView.leftAnchor),
            blurredEffectView.rightAnchor.constraint(equalTo: navControllerView.rightAnchor)
        ])
    }
}
