//
//  NetworkConstants.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 01.02.2024.
//

import Foundation

struct NetworkConstants {
    static var apiKey: String {
        get {
            return "2ccc9fcb3e886fcb5f80015418735095"
        }
    }
    
    static var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    static var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
}
