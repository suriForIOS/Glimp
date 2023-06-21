//
//  APIManager.swift
//  TheMarvels
//
//  Created by Surbhi Bagadia on 02/09/22.
//

import Foundation

class APIManager {
   
    public static let shared = APIManager()
    private init() {}
    
    func load<T : Decodable>(
        for endPoint: Endpoints,
        with params: [String: String],
        type: T.Type,
        withCompletion completion: @escaping (Result<[T], Error>) -> Void
    ) {
        guard let url = endPoint.url else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            do {
                let response = try JSONDecoder().decode([T].self, from: data!)
                DispatchQueue.main.async { completion(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        task.resume()
    }
}
