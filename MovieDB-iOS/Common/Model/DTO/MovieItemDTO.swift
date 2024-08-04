//
//  MovieItemDTO.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

struct MovieItemDTO {
    let id: Int
    let overview: String?
    private let originalTitle: String?
    private let releaseDate: String?
    private let voteAverage: Double?
    private let genreIds: [Int]?
    private let posterPath: String?
    private let backdropPath: String?
    private let originCountry: [String]?
    private let genres: [GenresResponse]?
    
    init(responseItem: MovieResponseItem) {
        self.id = responseItem.id
        self.originalTitle = responseItem.originalTitle
        self.releaseDate = responseItem.releaseDate
        self.voteAverage = responseItem.voteAverage
        self.posterPath = responseItem.posterPath
        self.genreIds = responseItem.genreIds
        self.overview = responseItem.overview
        self.originCountry = responseItem.originCountry
        self.backdropPath = responseItem.backdropPath
        self.genres = responseItem.genres
    }
    
    var titleAndYear: String {
        guard let originalTitle else { return "Unknown Movie Title" }
        guard let year else { return originalTitle }
        return originalTitle + " (\(year))"
    }
    
    var title: String {
        guard let originalTitle else { return "Unknown Movie Title" }
        return originalTitle
    }
    
    var year: Int? {
        guard let _ = releaseDate else { return nil }
        return releaseYear
    }
    
    var posterStringURL: String? {
        guard let posterPath else { return nil }
        return "\(AppConstants.MovieDB.mediumImageSizePath)\(posterPath)"
    }
    
    var backdropStringURL: String?? {
        guard let backdropPath else { return nil }
        return "\(AppConstants.MovieDB.mediumImageSizePath)\(backdropPath)"
    }
    
    var localGenres: String {
        guard let genreIds else { return .init() }
        return genreIds
            .compactMap { MovieGenreType(rawValue: $0)?.name }
            .joined(separator: ", ")
    }
    
    var networkGenres: String {
        guard let genres else { return .init() }
        return genres
            .compactMap { $0.name }
            .joined(separator: ", ")
    }
    
    var averageRating: String {
        guard let voteAverage else { return String("0.0") }
        return String(format: "%.1f", voteAverage)
    }
    
    private var countries: String? {
        guard let originCountry else { return nil }
        return originCountry
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    var countriesAndYear: String {
        guard let countries else { return "" }
        guard let year else { return countries }
        return countries + " (\(year))"
    }
    
    // MARK: - Release date calculation
    
    private var releaseYear: Int {
        let date = releaseDate.flatMap { dateFormatter.date(from: $0) } ?? Date()
        return Calendar.current.component(.year, from: date)
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
