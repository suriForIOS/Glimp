//
//  Endpoints.swift
//  TheMarvels
//
//  Created by Surbhi Bagadia on 02/09/22.
//

import Foundation

enum Endpoints {
    case channels
    case programs
    
    var path: String {
        switch self {
        case .channels:
            return "/json/Channels"
        case .programs:
            return "/json/ProgramItems"
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "demo-c.cdn.vmedia.ca"
        components.path = path
        return components.url
    }
}

