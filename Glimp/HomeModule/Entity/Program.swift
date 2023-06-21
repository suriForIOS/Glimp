//
//  Program.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

// MARK: - ProgramElement
struct Program: Codable {
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Double
    let name: String
}

// MARK: - RecentAirTime
struct RecentAirTime: Codable {
    let id, channelID: Int
}

