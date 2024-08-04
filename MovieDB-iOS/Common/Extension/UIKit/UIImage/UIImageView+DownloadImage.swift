//
//  UIImageView+DownloadImage.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func downloadImage(
        url: String?,
        withActivity style: UIActivityIndicatorView.Style,
        placeholderImage: UIImage = .moviePosterPlaceholder,
        completionHandler: ((Bool) -> Void)? = nil
    ) {
        guard let urlValue = url else {
            image = placeholderImage
            return
        }
        guard let url = URL(string: urlValue) else { return }
        
        self.startActivity(with: style)
        
        self.sd_setImage(
            with: url,
            placeholderImage: placeholderImage,
            options: .highPriority,
            progress: nil
        ) { [weak self] (image, error, _, _) in
            guard let strongSelf = self else { return }
            strongSelf.removeActivity()
            if error != nil {
                strongSelf.image = placeholderImage
            }
            completionHandler?(error == nil)
        }
    }
    
}
