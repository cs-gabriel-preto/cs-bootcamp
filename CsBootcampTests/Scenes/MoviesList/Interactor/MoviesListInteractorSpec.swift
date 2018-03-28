//
//  MoviesListInteractorSpec.swift
//  CsBootcampTests
//
//  Created by Andre Rodrigues on 28/03/18.
//  Copyright © 2018 Bootcampers. All rights reserved.
//

import Quick
import Nimble

@testable import CsBootcamp

class MoviesListInteractorSpec: QuickSpec {
    
    override func spec() {
        
        describe("MoviesListInteractor") {
            
            var presenter: MoviesListPresenterSpy!
            var gateway: MoviesListGatewayStub!
            var interactor: MoviesListInteractor!
            
            let setup = {
                presenter = MoviesListPresenterSpy()
                gateway = MoviesListGatewayStub()
                interactor = MoviesListInteractor(presenter: presenter, moviesListGateway: gateway)
            }
            
            context("when fetch movies is called") {
                
                context("when it succeeds") {
                    
                    let movies = (0..<3).map { id in
                        Movie(id: id, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "")
                    }
                    
                    beforeEach {
                        
                        setup()
                        gateway.result = .success(movies)
                        interactor.fetchMovies()
                    }
                    
                    it("should present the returned movies") {
                        
                        expect(presenter.presentMoviesCalled).to(beTrue())
                        expect(presenter.presentMoviesArg).to(equal(movies))
                    }
                }
                
                context("when it fails") {
                    
                    beforeEach {
                        
                        setup()
                        let error = NSError() as Error
                        gateway.result = .failure(error)
                        interactor.fetchMovies()
                    }
                    
                    it("should present error") {
                        
                        expect(presenter.presentErrorCalled).to(beTrue())
                    }
                }
            }
        }
    }
}

final class MoviesListPresenterSpy: MoviesListPresenterType {
    
    var presentMoviesCalled = false
    var presentMoviesArg: [Movie]?
    var presentErrorCalled = false
    
    func presentMovies(_ movies: [Movie]) {
        presentMoviesCalled = true
        presentMoviesArg = movies
    }
    
    func presentError() {
        presentErrorCalled = true
    }
}

final class MoviesListGatewayStub: MoviesListGateway {
    
    var result: Result<[Movie]>!
    
    func fetchMovies(_ completion: @escaping (Result<[Movie]>) -> ()) {
        
        completion(result)
    }
}
