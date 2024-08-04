//
//  MovieListViewController.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

final class MovieListViewController: SearchViewController {
    
    // MARK: - Closure
    
    var onOpenDetails: ((MovieItemDTO) -> Void)?
    
    // MARK: - Properties
    
    private let viewModel: MovieListViewModel
    
    // MARK: - Init
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        observeViewStates()
        getMovieList()
    }
    
    // MARK: - User actions
    
    @objc private func sortButtonAction() {
        var actions: [UIAlertAction] = []
        
        for sortOption in MovieSortOption.allCases {
            let action = UIAlertAction(
                title: sortOption.rawValue,
                style: .default
            ) { [weak self] action in
                self?.viewModel.sortMovies(by: sortOption)
            }
            
            let isChecked: Bool = sortOption == viewModel.sortOption
            action.setValue(isChecked, forKey: "checked")
            
            actions.append(action)
        }
        
        actions.append(.cancel)
        
        #warning("Localize")
        showActionSheet(
            title: "Choose Sorting Option",
            message: "Organize movies by your preferred criteria",
            actions: actions
        )
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        navigationItem.title = Constants.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .sortIcon,
            style: .plain,
            target: self,
            action: #selector(sortButtonAction)
        )
        
        view.backgroundColor = .white
    }
    
    // MARK: - User actions
    
    private func didSelectMovie(at indexPath: IndexPath) {
        showLoader()
        viewModel.getMovieDetails(at: indexPath) { [weak self] movieItemDTO in
            guard let self = self else { return }
            self.hideLoader()
            if let movieItemDTO {
                self.onOpenDetails?(movieItemDTO)
            }
        }
    }
    
    override func refreshData() {
        switch viewModel.paginationType {
        case .discover:
            getMovieList(forceRefresh: true)
        case .search:
            viewModel.search(viewModel.query, forceRefresh: true)
        }
        refreshControl.endRefreshing()
    }
    
    private func observeViewStates() {
        viewModel.didUpdateViewState = { [weak self] state in
            guard let self = self else { return }

            self.hideLoader()
            
            switch state {
            case .loading:
                if viewModel.numberOfEntities == 0 {
                    self.showLoader()
                }
            case let .failed(error):
                self.showErrorAlert(error.localizedDescription)
            default:
                break
            }
            
            self.reloadTableView()
        }
    }
    
    // MARK: - Network Requests
    
    private func getMovieList(forceRefresh: Bool = false) {
        viewModel.getMovies(forceRefresh: forceRefresh)
    }
    
    private func fetchNextPage() {
        viewModel.paginationModel.next()
        switch viewModel.paginationType {
        case .discover:
            getMovieList()
        case .search:
            viewModel.search(viewModel.query, forceRefresh: false)
        }
    }
    
    // MARK: - TableView Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MovieItemTableCell.self)
        if let modelDTO = viewModel.dataSource[safe: indexPath.row] {
            cell.setupCell(with: modelDTO)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let canPrefetchNext: Bool = indexPath.row >= viewModel.numberOfEntities - Constants.prefetchValue
        let notLoading: Bool = viewModel.viewState != .loading
        let isNotFullUploaded: Bool = !viewModel.paginationModel.isFullUploaded
        if canPrefetchNext && notLoading && isNotFullUploaded {
            fetchNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMovie(at: indexPath)
    }
    
    private struct Constants {
        #warning("Localize")
        static let title: String = "Popular Movies"
        static let prefetchValue: Int = 10
    }
    
}
