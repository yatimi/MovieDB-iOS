//
//  Router.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import UIKit

final class Router: NSObject, RouterProtocol {
    
    weak var rootController: UINavigationController!
    private var completions: [UIViewController: () -> Void]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ controller: UIViewController?) {
        present(controller, animated: true, completionHandler: nil)
    }
    
    func present(_ controller: UIViewController?, animated: Bool, completionHandler: (() -> Void)?) {
        guard let controller = controller else { return }
        rootController?.present(controller, animated: animated, completion: completionHandler)
    }
    
    func present(_ controller: UIViewController?, presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (() -> Void)?) {
        guard let controller = controller else { return }
        controller.modalPresentationStyle = presentationStyle
        rootController?.present(controller, animated: animated, completion: completionHandler)
    }
    
    func dismissController() {
        dismissController(animated: true, completion: nil)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ controller: UIViewController?)  {
        push(controller, animated: true)
    }
    
    func push(_ controller: UIViewController?, hideBottomBar: Bool)  {
        push(controller, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ controller: UIViewController?, animated: Bool)  {
        push(controller, animated: animated, completion: nil)
    }
    
    func push(_ controller: UIViewController?, animated: Bool, completion: (() -> Void)?) {
        push(controller, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ controller: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = controller,
            !(controller is UINavigationController)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popController()  {
        popController(animated: true)
    }
    
    func popController(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popTo(_ controller: UIViewController?) {
        guard let controller = controller else { return }
        rootController.popToViewController(controller, animated: true)
    }
    
    func setRootController(_ controller: UIViewController?) {
        setRootController(controller, hideBar: false)
    }
    
    func setRootController(_ controller: UIViewController?, hideBar: Bool) {
        guard let controller = controller else { return }
        rootController?.setViewControllers([controller], animated: true)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootController(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
