//
//  UITableViewCell+Shadow.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

extension UITableViewCell {
    
    func applyShadow(
        to container: UIView,
        cornerRadius: CGFloat = 0,
        shadowOpacity: Float = 1,
        shadowRadius: CGFloat = 1,
        shadowColor: UIColor = .black
    ) {
        container.layer.cornerRadius = cornerRadius
        container.layer.masksToBounds = true
        
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.masksToBounds = false
    }
    
}
