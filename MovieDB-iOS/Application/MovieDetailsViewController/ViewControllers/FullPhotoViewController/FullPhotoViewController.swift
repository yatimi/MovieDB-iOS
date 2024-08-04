//
//  FullPhotoViewController.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

final class FullPhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: FullPhotoViewModel
    
    // MARK: - Interface
    
    private var fullPhotoImageView: InteractiveImageView!
    
    // MARK: - Init
    
    init(viewModel: FullPhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        #if DEBUG
        print("💭 deinit " + type(of: self).nameOfClass)
        #endif
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteractiveImageView()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupInteractiveImageView() {
        fullPhotoImageView = InteractiveImageView(
            frame: view.bounds,
            image: viewModel.image
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        fullPhotoImageView.clipsToBounds = true
        
        view.addSubview(fullPhotoImageView)
        fullPhotoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
