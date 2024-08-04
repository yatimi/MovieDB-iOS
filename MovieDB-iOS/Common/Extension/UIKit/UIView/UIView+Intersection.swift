//
//  UIView+Intersection.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

extension UIView {
    
    func intersection(_ r2: CGRect) -> CGRect {
        guard let window = window else { return .zero }
        
        let ownFrame = window.convert(frame, from: superview)
        var coveredFrame = ownFrame.intersection(r2)
        coveredFrame = window.convert(coveredFrame, to: superview)
        
        return coveredFrame
    }
    
}
