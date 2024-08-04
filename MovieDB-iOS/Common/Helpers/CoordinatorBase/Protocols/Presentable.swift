//  Presentable.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 05.08.2024.
//

import Foundation
import UIKit

protocol Presentable: AnyObject {

    func toPresent() -> UIViewController?

}
