//
//  MovieResponseItem.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

struct MovieResponseItem: Codable {
    let id: Int
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate, title: String?
    let voteAverage: Double?
    let genreIds: [Int]?
    let originCountry: [String]?
    let genres: [GenresResponse]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title, genres
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case originCountry = "origin_country"
    }
}
