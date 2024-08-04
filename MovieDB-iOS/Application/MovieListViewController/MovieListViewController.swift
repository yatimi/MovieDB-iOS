//
//  MovieListViewController.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

final class MovieListViewController: SearchViewController {
    
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: MovieItemTableCell.self)
        let model = viewModel.dataSource[indexPath.row]
        cell.setupCell(with: model)
        return cell
    }
    
    private struct Constants {
        #warning("Localize")
        static let title: String = "Popular Movies"
        static let prefetchValue: Int = 10
    }
    
}
