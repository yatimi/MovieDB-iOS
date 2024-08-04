//
//  UITableView+Register.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func dequeueReusableCell<Cell: Reusable>(type: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? Cell else {
            fatalError("Failed to dequeue cell with identifier: " + Cell.reuseIdentifier)
        }
        return cell
    }
    
    func dequeueReusableHeaderView<HeaderView: Reusable>() -> HeaderView {
        guard let headerView = dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView else {
            fatalError("Failed to dequeue header view with identifier: " + HeaderView.reuseIdentifier)
        }
        return headerView
    }
    
    func register<Cell: UITableViewCell>(type: Cell.Type) {
        register(type, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<Cell: UITableViewHeaderFooterView>(type: Cell.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooter<HeaderFooterView: UITableViewHeaderFooterView>(type: HeaderFooterView.Type) -> HeaderFooterView {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterView.reuseIdentifier) as? HeaderFooterView else {
            fatalError("Failed to dequeue headerFooterView with identifier: " + HeaderFooterView.reuseIdentifier)
        }
        return header
    }
    
    func makeCell<T: UITableViewCell>(ofType type: T.Type, _ builder: (T) -> Void) -> T {
        let cell = dequeueReusableCell(type: type)
        builder(cell)
        return cell
    }
    
    func makeCell<T: UITableViewCell>(_ builder: (T) -> Void) -> T {
        return makeCell(ofType: T.self, builder)
    }
    
    func makeHeaderFooter<T: UITableViewHeaderFooterView>(ofType type: T.Type, _ builder: (T) -> Void) -> T {
        let header = dequeueReusableHeaderFooter(type: type)
        builder(header)
        return header
    }
    
    func makeHeaderFooter<T: UITableViewHeaderFooterView>(_ builder: (T) -> Void) -> T {
        return makeHeaderFooter(ofType: T.self, builder)
    }
    
}
