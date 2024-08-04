//
//  SeparatedInfoView.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

final class SeparatedInfoView: UIView {
    
    // MARK: - Interface
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(separatorView)
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorView.layer.cornerRadius = Constants.separatorHeight / 2
    }
    
    // MARK: - Public methods
    
    func setup(title: String, subtitle: String) {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        
        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .regular),
            .foregroundColor: UIColor.darkGray
        ]
        
        let attributedTitle = NSAttributedString(string: title + ": ", attributes: titleAttributes)
        let attributedSubtitle = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedTitle)
        combinedAttributedString.append(attributedSubtitle)
        
        titleLabel.attributedText = combinedAttributedString
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(Constants.separatorHeight)
        }
    }
    
    private struct Constants {
        static let separatorHeight: CGFloat = 1
        static let stackViewSpacing: CGFloat = 10
    }
    
}
