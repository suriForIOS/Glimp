//
//  HomeService.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

class HomeService {
    static let shared = HomeService()
    
    func getChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        APIManager.shared.load(for: .channels, with: [:], type: Channel.self, withCompletion: completion)
    }
    
    func getPrograms(completion: @escaping (Result<[Program], Error>) -> Void) {
        APIManager.shared.load(for: .programs, with: [:], type: Program.self, withCompletion: completion)
    }
}
