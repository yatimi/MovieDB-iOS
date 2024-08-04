//  RouterProtocol.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

protocol RouterProtocol {
    
    func present(_ controller: UIViewController?)
    func present(_ controller: UIViewController?, animated: Bool, completionHandler: (() -> Void)?)
    func present(_ controller: UIViewController?, presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (() -> Void)?)
    
    func push(_ controller: UIViewController?)
    func push(_ controller: UIViewController?, hideBottomBar: Bool)
    func push(_ controller: UIViewController?, animated: Bool)
    func push(_ controller: UIViewController?, animated: Bool, completion: (() -> Void)?)
    func push(_ controller: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popController()
    func popController(animated: Bool)
    
    func dismissController()
    func dismissController(animated: Bool, completion: (() -> Void)?)
    
    func setRootController(_ controller: UIViewController?)
    func setRootController(_ controller: UIViewController?, hideBar: Bool)
    
    func popToRootController(animated: Bool)
    
}
