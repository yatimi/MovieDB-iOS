//  Coordinator.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import Foundation

protocol Coordinator: AnyObject {

    func start(deepLinkOption: DeepLinkOption?)
    
}
