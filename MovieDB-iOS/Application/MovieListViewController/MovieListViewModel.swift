//
//  MovieListViewModel.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

final class MovieListViewModel: SearchableTableViewModel {
    
    // MARK: - Closure:
    
    var didUpdateViewState: ((ViewState) -> Void)?
    
    // MARK: - Properties
    
    var numberOfEntities: Int {
        dataSource.count
    }
    
    var query: String = ""
    var sortOption: MovieSortOption = .popularityDescending
    var paginationModel = PaginationModel()
    
    private(set) var viewState: ViewState = .idle {
        didSet { didUpdateViewState?(viewState) }
    }
    
    private(set) var dataSource: [MovieItemDTO] = .init()
    private(set) var paginationType: PaginationType = .discover
    
    private var searchTimer: Timer?
    private let networkManager: MoviesNetworkService
    
    // MARK: - Init
    
    init(networkManager: MoviesNetworkService = MoviesNetworkServiceImpl()) {
        self.networkManager = networkManager
    }
    
    // MARK: - ViewState
    
    func setState(_ newState: ViewState) {
        self.viewState = newState
    }
    
    // MARK: - Public methods
    
    func sortMovies(by option: MovieSortOption) {
        sortOption = option
        getMovies(forceRefresh: true)
    }
    
    func search(_ query: String, forceRefresh: Bool = false) {
        if !self.query.isEmpty && query.isEmpty {
            getMovies(forceRefresh: true)
        } else {
            guard !query.isEmpty else { return }
            
            if forceRefresh {
                eraseData()
            }
            
            paginationType = .search
            self.query = query
            
            setState(.loading)
            
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                self.networkManager.searchMovies(
                    with: paginationModel,
                    searchQuery: query
                ) { [weak self] result in
                    guard let self = self else { return }
                    self.handleNetworkResponse(result: result)
                }
            }
        }
    }
    
    func getMovies(forceRefresh: Bool = false)  {
        guard viewState != .loading else  { return }
        
        if forceRefresh {
            eraseData()
        }
        
        paginationType = .discover
        
        setState(.loading)
        
        networkManager.getMovies(
            with: paginationModel,
            by: sortOption
        ) { [weak self] result in
            guard let self = self else { return }
            self.handleNetworkResponse(result: result)
        }
    }
    
    // MARK: - Help methods
    
    private func handleNetworkResponse(
        result:  Result<MovieListResponse, MoviesNetworkError>
    ) {
        switch result {
        case .success(let response):
            let DTOs = response.results.compactMap { MovieItemDTO(responseItem: $0) }
            self.dataSource.append(contentsOf: DTOs)
            self.setState(.loaded)
            self.paginationModel.isFullUploaded = response.totalPages == paginationModel.page
        case .failure(let error):
            self.setState(.failed(error))
        }
    }
    
    private func eraseData() {
        paginationModel = .init()
        dataSource.removeAll()
        viewState = .idle
        searchTimer?.invalidate()
        query = ""
    }
    
}

// MARK: - ViewState

extension MovieListViewModel {
    
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case failed(MoviesNetworkError)
    }
    
    enum PaginationType {
        case discover
        case search
    }
    
}
