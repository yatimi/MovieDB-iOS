//
//  MovieGenreType.swift
//  MovieDB-iOS
//
//  Created by Artem Zabihailo on 04.08.2024.
//

import Foundation

enum MovieGenreType: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    var name: String {
        switch self {
        case .action: return "genre_action".localize()
        case .adventure: return "genre_adventure".localize()
        case .animation: return "genre_animation".localize()
        case .comedy: return "genre_comedy".localize()
        case .crime: return "genre_crime".localize()
        case .documentary: return "genre_documentary".localize()
        case .drama: return "genre_drama".localize()
        case .family: return "genre_family".localize()
        case .fantasy: return "genre_fantasy".localize()
        case .history: return "genre_history".localize()
        case .horror: return "genre_horror".localize()
        case .music: return "genre_music".localize()
        case .mystery: return "genre_mystery".localize()
        case .romance: return "genre_romance".localize()
        case .scienceFiction: return "genre_science_fiction".localize()
        case .tvMovie: return "genre_tv_movie".localize()
        case .thriller: return "genre_thriller".localize()
        case .war: return "genre_war".localize()
        case .western: return "genre_western".localize()
        }
    }
}
