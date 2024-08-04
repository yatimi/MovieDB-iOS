//
//  UIMaker.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

struct UIMaker {
    
    static func createAttributedText(
        text: String,
        symbolName: String,
        tintColor: UIColor = .systemYellow,
        font: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    ) -> NSAttributedString {
        let attachment = NSTextAttachment()
        if let starImage = UIImage(systemName: symbolName) {
            attachment.image = starImage.withTintColor(tintColor)
        }
            
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(
            string: " \(text)",
            attributes: [.font: font])
        )
            
        return attributedString
    }
    
    static func createEmptyListLabel(text: String) ->  UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.isHidden = true
        return label
    }
    
}
