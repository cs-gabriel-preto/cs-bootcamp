//
//  MovieDetailViewController.swift
//  CsBootcamp
//
//  Created by Lucas Nascimento on 23/03/2018.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import UIKit

protocol MovieDetailInteractorType {
    
    func fetchDetail(of movie: Movie)
}

final class MovieDetailViewController: UIViewController, MovieDetailView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        
        tableView.estimatedSectionHeaderHeight = 1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return tableView
    }()
    
    let movie: Movie
    
    var interactor: MovieDetailInteractorType?
    var movieDetailFavoriteInteractor: MovieDetailFavoriteInteractorType?
    
    lazy var dataSource: MovieDetailDataSource = {
        let dataSource = MovieDetailDataSource(tableView: self.tableView)
        dataSource.favoriteButtonTapped = self.toggleFavorite
        
        return dataSource
    }()
    
    init(movie: Movie) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Movie"
        view.backgroundColor = .white
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.fetchDetail(of: movie)
        super.viewWillAppear(animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func displayMovieDetail(viewModel: ViewModel) {
        
        dataSource.viewModel = viewModel
    }
    
    private func toggleFavorite() {
        movieDetailFavoriteInteractor?.toggleMovieFavorite()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView
            .topAnchor(equalTo: view.topAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
    }
}

extension MovieDetailViewController {
    
    struct ViewModel {
        
        let poster: MoviePosterTableViewCell.ViewModel
        let releaseDate: MovieTextTableViewCell.ViewModel
        let genres: MovieTextTableViewCell.ViewModel
        let overview: MovieOverviewTableViewCell.ViewModel
    }
}
