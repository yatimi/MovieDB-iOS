//
//  UIView + ActivityIndicator.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit
import SnapKit

extension UIView {
    
    func startActivity(
        color: UIColor = UIColor.black,
        with style: UIActivityIndicatorView.Style = .medium,
        constraints: ((_ make: ConstraintMaker) -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            let view = UIActivityIndicatorView()
            view.color = color
            view.style = style
            view.isUserInteractionEnabled = false
            view.startAnimating()
            
            self.addSubview(view)
            view.snp.makeConstraints { make in
                if let constraints {
                    constraints(make.self)
                } else {
                    make.center.equalToSuperview()
                }
            }
        }
    }
    
    func removeActivity() {
        DispatchQueue.main.async {
            for activity in self.subviews where (activity as? UIActivityIndicatorView) != nil {
                activity.removeFromSuperview()
            }
        }
    }
    
}
