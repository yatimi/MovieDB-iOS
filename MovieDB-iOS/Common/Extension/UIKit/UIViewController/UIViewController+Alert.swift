//
//  UIViewController+Alert.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

extension UIViewController {
    
    func alert(
        _ title: String? = nil, message: String? = nil,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction], preferredAction: UIAlertAction? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach(alertController.addAction)
        alertController.preferredAction = preferredAction
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
    func showActionSheet(title: String? = nil, message: String? = nil, actions: [UIAlertAction]) {
        alert(title, message: message, style: .actionSheet, actions: actions)
    }
    
}

extension UIViewController {
    func showErrorAlert(_ text: String) {
        alert("error".localize(), message: text, style: .alert, actions: [.cancel], preferredAction: nil)
    }
}

extension UIAlertAction {
    static var cancel: UIAlertAction {
        UIAlertAction(title: "cancel".localize(), style: .cancel)
    }
}
