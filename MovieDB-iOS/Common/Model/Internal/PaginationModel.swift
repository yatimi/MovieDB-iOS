//
//  PaginationModel.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

struct PaginationModel {
    var page: Int = 1
    var isFullUploaded: Bool = false
    
    mutating func next() {
        page += 1
    }
}
