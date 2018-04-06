//
//  MoviesFilterViewController.swift
//  CsBootcamp
//
//  Created by Lucas Nascimento on 05/04/2018.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import UIKit

protocol MoviesFilterInteractorType: class {
    func showFilterDetail(at index: Int)
}

class MoviesFilterViewController: UIViewController, FilterView {


    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Bootcamp.yellow
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Aplicar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var dataSource: MoviesFilterDataSource = {
        
        let dataSource = MoviesFilterDataSource(tableView: tableView)
        return dataSource
    }()
    
    var moviesFilterInteractorType: MoviesFilterInteractorType?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Filtro"
        view.backgroundColor = .white
        dataSource.didSelectItem = self.filterSelected
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func filterSelected(at index: Int) {
        moviesFilterInteractorType?.showFilterDetail(at: index)
    }

    func displayFilterDetail(viewModels: [String]) {
        setup(viewModels: viewModels)
    }
    
    private func setup(viewModels: [String]) {
        dataSource.viewModels = viewModels
    }
    
    func navigateToDetailOfFilter(index: Int) {
        let vc = FilterDetailTableViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
    }
    
    private func setupConstraints() {

        tableView
            .topAnchor(equalTo: view.topAnchor)
            .bottomAnchor(equalTo: applyButton.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
        
        applyButton
            .bottomAnchor(equalTo: view.bottomAnchor, constant: -64)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -32)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 32)
            .heightAnchor(equalTo: 44)
        
    }
}