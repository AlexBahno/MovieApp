//
//  APICaller.swift
//  MovieApp
//
//  Created by Alexandr Bahno on 01.02.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case urlError
    case cannnotParseData
}

final public class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    func getTrendingMovies(
        completion: @escaping (Result<MovieResponse, NetworkError>) -> Void
    ) {
        let urlString = NetworkConstants.serverAddress +
                        "movie/now_playing?api_key=" +
                        NetworkConstants.apiKey
        AF.request(urlString)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if response.error != nil {
                        completion(.failure(.urlError))
                    }
                    return
                }
                let decoder = JSONDecoder()
                let results = try? decoder.decode(MovieResponse.self, from: data)
                guard let results = results else {
                    completion(.failure(.cannnotParseData))
                    return
                }
                completion(.success(results))
            }
    }
}
