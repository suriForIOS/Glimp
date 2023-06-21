//
//  Channel.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

// MARK: - ChannelElement
struct Channel: Codable {
    let orderNum, accessNum: Int
    let callSign: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case orderNum, accessNum
        case callSign = "CallSign"
        case id
    }
}
