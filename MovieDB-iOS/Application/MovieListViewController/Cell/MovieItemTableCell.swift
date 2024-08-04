//
//  MovieItemTableCell.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

final class MovieItemTableCell: UITableViewCell {
    
    // MARK: - Interface
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleAndYearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        label.lineBreakMode = .byTruncatingMiddle
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .moviePosterPlaceholder
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var verticalTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(titleAndYearLabel)
        stackView.addArrangedSubview(genresLabel)
        stackView.addArrangedSubview(ratingLabel)
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleAndYearLabel.text = nil
        genresLabel.text = nil
        ratingLabel.text = nil
        movieImageView.image = .moviePosterPlaceholder
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.layer.cornerRadius = Constants.moviePosterImageCornerRadius
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: true)

        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            let alpha: CGFloat = highlighted ? 0.9 : 1.0
            let transform = highlighted ?
                CGAffineTransform.identity.scaledBy(x: 0.97, y: 0.97) :
                .identity
            
            self.alpha = alpha
            self.transform = transform
        })
    }
    
    // MARK: - Public methods
    
    func setupCell(with model: String) {
        titleAndYearLabel.text = model
        genresLabel.text = "Genres"
        ratingLabel.attributedText = UIMaker.createAttributedText(
            text: "7.8",
            symbolName: "star.fill"
        )
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        applyShadow(
            to: container,
            cornerRadius: Constants.containerCornerRadius,
            shadowOpacity: Constants.shadowOpacity,
            shadowRadius: Constants.shadowRadius
        )
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.outerHorizontalInset)
            make.verticalEdges.equalToSuperview().inset(Constants.outerVerticalInset)
            make.height.greaterThanOrEqualTo(Constants.imageHeight + Constants.innerVerticalInset * 2)
        }
        
        container.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageHeight)
            make.width.equalTo(Constants.imageWidth)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.innerHorizontalInset)
        }
        
        container.addSubview(verticalTextStackView)
        verticalTextStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.innerVerticalInset)
            make.leading.equalTo(movieImageView.snp.trailing).offset(Constants.innerHorizontalInset)
            make.trailing.equalToSuperview().inset(Constants.innerHorizontalInset)
        }
    }
    
    private struct Constants {
        static let imageHeight: CGFloat = 150
        static let imageWidth: CGFloat = 100
        
        static let innerHorizontalInset: CGFloat = 15
        static let outerHorizontalInset: CGFloat = 20
        
        static let innerVerticalInset: CGFloat = 15
        static let outerVerticalInset: CGFloat = 10
        
        static let moviePosterImageCornerRadius: CGFloat = 8
        static let stackViewSpacing: CGFloat = 10
        
        static let containerCornerRadius: CGFloat = 16
        static let shadowOpacity: Float = 0.25
        static let shadowRadius: CGFloat = 5
    }
    
}
