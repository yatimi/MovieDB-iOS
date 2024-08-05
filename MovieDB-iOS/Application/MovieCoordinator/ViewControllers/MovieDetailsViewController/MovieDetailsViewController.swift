//
//  MovieDetailsViewController.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Closure
    
    var onOpenFullPhoto: ((UIImage) -> Void)?
    
    // MARK: - Interface
    
    private let scrollView = UIScrollView()
    private let container = UIView()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .moviePosterPlaceholder
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomInOutProcess)))
        return imageView
    }()
    
    private let movieTitleInfoView = SeparatedInfoView()
    private let countryAndYearInfoView = SeparatedInfoView()
    private let genreInfoView = SeparatedInfoView()
    private let descriptionInfoView = SeparatedInfoView()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 15
        
        stackView.addArrangedSubview(movieTitleInfoView)
        stackView.addArrangedSubview(countryAndYearInfoView)
        if !viewModel.movieItemDTO.networkGenres.isEmpty {
            stackView.addArrangedSubview(genreInfoView)
        }
        stackView.addArrangedSubview(ratingLabel)
        if let overview = viewModel.movieItemDTO.overview, !overview.isEmpty {
            stackView.addArrangedSubview(descriptionInfoView)
        }
        return stackView
    }()
    
    // MARK: - Properties
    
    private let viewModel: MovieDetailsViewModel
    
    // MARK: - Init
    
    init(viewModel: MovieDetailsViewModel) {
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
        setupUI()
        setupInfo()
    }
    
    // MARK: - User actions
    
    @objc private func zoomInOutProcess() {
        guard
            viewModel.movieItemDTO.backdropStringURL != nil,
            let image = posterImageView.image else {
            return
        }
        onOpenFullPhoto?(image)
    }
    
    // MARK: - Private methods
    
    private func setupInfo() {
        title = viewModel.movieItemDTO.title
        posterImageView.downloadImage(url: viewModel.movieItemDTO.backdropStringURL, withActivity: .medium)
        movieTitleInfoView.setup(title: "movie_details_title".localize(), subtitle: viewModel.movieItemDTO.title)
        genreInfoView.setup(title: "movie_details_genres".localize(), subtitle: viewModel.movieItemDTO.networkGenres)
        countryAndYearInfoView.setup(title: "movie_details_country_year".localize(), subtitle: viewModel.movieItemDTO.countriesAndYear)
        descriptionInfoView.setup(title: "movie_details_overview".localize(), subtitle: viewModel.movieItemDTO.overview ?? .init())
        ratingLabel.attributedText = UIMaker.createAttributedText(
            text: "movie_rating".localize(arguments: viewModel.movieItemDTO.averageRating),
            symbolName: "star.fill"
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        container.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        container.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(container.snp.top)
            make.height.equalTo(Constants.posterImageHeight)
        }
        
        container.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalInset)
            make.top.equalTo(posterImageView.snp.bottom).offset(Constants.horizontalInset)
            make.bottom.equalToSuperview().inset(Constants.horizontalInset)
        }
    }
    
    private struct Constants {
        static let posterImageHeight: CGFloat = 250
        static let horizontalInset: CGFloat = 20
    }
    
}
