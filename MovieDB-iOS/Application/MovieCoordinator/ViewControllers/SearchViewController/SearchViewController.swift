//
//  SearchViewController.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: SearchableTableViewModel
    
    // MARK: - Interface
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(type: MovieItemTableCell.self)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private let emptyListLabel = UIMaker.createEmptyListLabel(
        text: Constants.emptyListLabelText
    )
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Init
    
    init(viewModel: SearchableTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self, selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
        notificationCenter.addObserver(
            self, selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil
        )
    }
    
    // MARK: - Public methods
    
    func showLoader() {
        emptyListLabel.isHidden = true
        view.startActivity()
    }
    
    func hideLoader() {
        view.removeActivity()
        emptyListLabel.isHidden = viewModel.numberOfEntities != 0
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - User actions
    
    @objc func refreshData() {}
    
    // MARK: - Keyboard Observer
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboardValue.cgRectValue
        let coveredFrame = tableView.intersection(keyboardFrame)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset.bottom = .zero
        } else {
            tableView.contentInset.bottom = coveredFrame.height
        }
    }
    
    // MARK: - Network Request
    
    private func executeSearch(by query: String) {
        viewModel.search(query, forceRefresh: true)
    }
    
    // MARK: - Private methods
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = Constants.searchBarPlaceholderText
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(emptyListLabel)
        emptyListLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.emptyListLabelHInset)
            make.centerY.equalToSuperview()
        }
    }
    
    private struct Constants {
        static let searchBarPlaceholderText: String = "find_your_favorite_movies".localize()
        static let emptyListLabelText: String = "no_movies_found".localize()
        static let emptyListLabelHInset: CGFloat = 16
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
 
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEntities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        executeSearch(by: .init())
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query: String = searchText.lowercased()
        executeSearch(by: query)
        reloadTableView()
    }
}
